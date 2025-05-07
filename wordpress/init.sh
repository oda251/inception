#!/bin/bash

echo "Waiting for MariaDB connection at ${WORDPRESS_DB_HOST}..."
until mysqladmin ping -h"${WORDPRESS_DB_HOST}" -P3306 --silent; do
    echo "MariaDB is not available yet - sleeping for 2 seconds..."
    sleep 2
done
echo "MariaDB is up."

cd /var/www/html

if [ ! -f /var/www/html/wp-config.php ]; then

	echo "WordPress is not installed. Proceeding with installation..."
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
	wp core install	--allow-root \
						--url=$WORDPRESS_URL \
						--title=$WORDPRESS_TITLE \
						--admin_user=$WORDPRESS_ADMIN \
						--admin_password=$WORDPRESS_ADMIN_PASSWORD \
						--admin_email=$WORDPRESS_ADMIN_EMAIL \
						--skip-email \
						--path=/var/www/html/

	echo "Creating WordPress user..."
	wp user create	--allow-root \
						$WORDPRESS_USER \
						$WORDPRESS_USER_EMAIL \
						--user_pass=$WORDPRESS_USER_PASSWORD \
						--role=author \
						--path=/var/www/html/

else
	echo "WordPress is already installed."
fi

echo "Starting PHP-FPM..."
php-fpm7.4 -F