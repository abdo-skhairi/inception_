#!/bin/bash

set -e

if [ ! -f wp-config.php ]; then
    # Read passwords from secrets
    WP_DB_PASSWORD=$(cat /run/secrets/db_password)
    WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
    WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)
    mkdir -p /var/www/wordpress
    cd /var/www/wordpress
    
    echo "Configuring WordPress..."
    
    wp core download --locale=en_US --allow-root
    echo "WordPress downloaded."
    
    # the creation of wp-config.php 
    wp config create --dbname=$WORDPRESS_DB_NAME --dbuser=$WORDPRESS_DB_USER --dbpass=$WORDPRESS_DB_USER_PASSWORD --dbhost=$WORDPRESS_DB_HOST --allow-root
    echo "Database configuration created."
    
    wp core install \
        --url=$WORDPRESS_URL \
        --title="$WORDPRESS_TITLE" \
        --admin_user=$WORDPRESS_ADMIN_USER \
        --admin_password=$WORDPRESS_ADMIN_PASSWORD \
        --admin_email=$WORDPRESS_ADMIN_EMAIL \
        --allow-root
    echo "WordPress installed."
    
    # connecting to mariadb and creating of wordpress tables using wp-config.php 
    if [ "$WORDPRESS_USER" != "$WORDPRESS_ADMIN_USER" ]; then
        wp user create \
            $WORDPRESS_USER \
            $WORDPRESS_USER_EMAIL \
            --user_pass=$WORDPRESS_USER_PASSWORD \
            --role=author \
            --allow-root
        echo "WordPress user created."
    else
        echo "WordPress regular user skipped because it matches the admin user."
    fi
    
    wp theme install oceanwp --activate --allow-root
    echo "Theme installed and activated."

    echo "WordPress configured successfully."
else
    echo "WordPress is already configured."
fi

chown -R www-data:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress

echo "Starting PHP-FPM..."
exec php-fpm8.2 -F
