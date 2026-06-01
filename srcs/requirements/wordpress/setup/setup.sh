#!/bin/bash

set -e

mkdir -p /var/www/wordpress
cd /var/www/wordpress

echo "Checking WordPress installation state..."

# Read secrets every time (important: not only on first install)
WP_DB_PASSWORD=$(cat /run/secrets/db_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)

echo "Configuring WordPress..."

# Always ensure WordPress is downloaded
if [ ! -f wp-config.php ]; then
    wp core download --locale=en_US --allow-root
    echo "WordPress downloaded."

    wp config create \
        --dbname=$WORDPRESS_DB_NAME \
        --dbuser=$WORDPRESS_DB_USER \
        --dbpass=$WP_DB_PASSWORD \
        --dbhost=$WORDPRESS_DB_HOST \
        --allow-root

    echo "Database configuration created."

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
    echo "WordPress already installed, skipping core install."
fi

# 🔥 ALWAYS enforce correct passwords (IMPORTANT FIX)
echo "Ensuring admin password is synced with secrets..."
wp user update $WORDPRESS_ADMIN_USER \
    --user_pass=$WP_ADMIN_PASSWORD \
    --allow-root

# Create regular user (safe even if already exists)
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
else
    echo "Regular user skipped (same as admin)."
fi

# Theme install (idempotent)
if ! wp theme is-installed oceanwp --allow-root; then
    wp theme install oceanwp --activate --allow-root
    echo "Theme installed and activated."
else
    wp theme activate oceanwp --allow-root
    echo "Theme already installed, activated."
fi

echo "WordPress configured successfully."

chown -R www-data:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress

echo "Starting PHP-FPM..."
exec php-fpm8.2 -F