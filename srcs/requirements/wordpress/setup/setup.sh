#!/bin/bash
set -e
mkdir -p /var/www/wordpress
cd /var/www/wordpress
# Read secrets
WP_DB_PASSWORD=$(cat /run/secrets/db_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)
# Wait for MariaDB
echo "Waiting for MariaDB..."
until mysqladmin ping -h "$WORDPRESS_DB_HOST" -u "$WORDPRESS_DB_USER" -p"$WP_DB_PASSWORD" --silent 2>/dev/null; do
    echo "MariaDB not ready, retrying in 3s..."
    sleep 3
done
echo "MariaDB is ready!"
echo "Checking WordPress installation state..."
# Download core files if not already present
if [ ! -f wp-login.php ]; then
    echo "Downloading WordPress..."
    wp core download --locale=en_US --allow-root
else
    echo "WordPress core files already present, skipping download."
fi
# Create config and install if not already configured
if [ ! -f wp-config.php ]; then
    echo "Creating wp-config.php..."
    wp config create \
        --dbname=$WORDPRESS_DB_NAME \
        --dbuser=$WORDPRESS_DB_USER \
        --dbpass=$WP_DB_PASSWORD \
        --dbhost=$WORDPRESS_DB_HOST \
        --allow-root
    echo "Installing WordPress..."
    wp core install \
        --url=$WORDPRESS_URL \
        --title="$WORDPRESS_TITLE" \
        --admin_user=$WORDPRESS_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WORDPRESS_ADMIN_EMAIL \
        --skip-email \
        --allow-root
    echo "WordPress installed."
else
    echo "WordPress already installed, skipping."
fi
# Sync admin password
wp user update $WORDPRESS_ADMIN_USER --user_pass=$WP_ADMIN_PASSWORD --allow-root
# Create regular user
if [ "$WORDPRESS_USER" != "$WORDPRESS_ADMIN_USER" ]; then
    if ! wp user get $WORDPRESS_USER --allow-root >/dev/null 2>&1; then
        wp user create \
            $WORDPRESS_USER \
            $WORDPRESS_USER_EMAIL \
            --user_pass=$WP_USER_PASSWORD \
            --role=author \
            --allow-root
        echo "WordPress user created."
    else
        echo "WordPress user already exists."
    fi
fi
# Theme
if ! wp theme is-installed oceanwp --allow-root; then
    wp theme install oceanwp --activate --allow-root
else
    wp theme activate oceanwp --allow-root
fi
chown -R www-data:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress
echo "Starting PHP-FPM..."
exec php-fpm8.2 -F