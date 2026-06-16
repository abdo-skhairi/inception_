#!/bin/sh
set -e

mkdir -p /run/mysqld/
chown -R mysql:mysql /run/mysqld/
chmod 750 /run/mysqld/
chown -R mysql:mysql /var/lib/mysql
chmod -R 755 /var/lib/mysql

# Read secrets
DB_PASSWORD=$(cat /run/secrets/db_password)
ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

if [ ! -d /var/lib/mysql/${WORDPRESS_DB_NAME} ]; then
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql

    cat << EOF > /tmp/init.sql
USE mysql;
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS \`${WORDPRESS_DB_NAME}\`;
CREATE USER IF NOT EXISTS '${WORDPRESS_DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${WORDPRESS_DB_NAME}\`.* TO '${WORDPRESS_DB_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

    mariadbd --user=mysql --bootstrap < /tmp/init.sql
    rm -f /tmp/init.sql
fi

exec mariadbd --user=mysql --bind-address 0.0.0.0