#!/bin/bash

mkdir -p /run/php

sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf
sed -i 's/;listen.allowed_clients = 127.0.0.1/listen.allowed_clients = 0.0.0.0/g' /etc/php/7.4/fpm/pool.d/www.conf

mkdir -p /run/php

echo "Waiting for MariaDB connection at ${WORDPRESS_DB_HOST}..."
until mysqladmin ping -h"${WORDPRESS_DB_HOST}" -P3306 --silent; do
    echo "MariaDB is not available yet - sleeping for 2 seconds..."
    sleep 2
done
echo "MariaDB is up."

# if [ ! -f /var/www/html/wp-config.php ]; then

    echo "Downloading WordPress..."
	wp core download --path=/var/www/html --locale=ja --allow-root

    echo "Configuring WordPress..."
	wp config create	--path=/var/www/html \
						--allow-root \
						--dbname=$WORDPRESS_DB_NAME \
						--dbuser=$WORDPRESS_DB_USER \
						--dbpass=$WORDPRESS_DB_PASSWORD \
						--dbhost=$WORDPRESS_DB_HOST

    echo "Installing WordPress..."
	wp core install		--allow-root \
						--url=$WORDPRESS_URL \
						--title=$WORDPRESS_TITLE \
						--admin_user=$WORDPRESS_ADMIN \
						--admin_password=$WORDPRESS_ADMIN_PASSWORD \
						--admin_email=$WORDPRESS_ADMIN_EMAIL \
						--skip-email \
						--path=/var/www/html/

    echo "Creating WordPress user..."
	wp user create		--allow-root \
						$WORDPRESS_USER \
						$WORDPRESS_USER_EMAIL \
						--user_pass=$WORDPRESS_USER_PASSWORD \
						--role=author \
						--path=/var/www/html/
# fi

chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

echo "Starting PHP-FPM..."
exec "$@"