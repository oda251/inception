#!/bin/bash

mkdir -p /download
mkdir -p /var/www/html
cd /var/www/html

wget https://wordpress.org/latest.tar.gz -O /download/latest.tar.gz
tar -xzvf /download/latest.tar.gz -C /var/www/html --strip-components=1

mkdir -p /run/php

sleep 5

if [ ! -f /var/www/html/wp-config.php ]; then
    cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
    sed -i "s/database_name_here/$MYSQL_DATABASE/" /var/www/html/wp-config.php
    sed -i "s/username_here/$MYSQL_USER/" /var/www/html/wp-config.php
    sed -i "s/password_here/$MYSQL_PASSWORD/" /var/www/html/wp-config.php
    sed -i "s/localhost/$MYSQL_HOST/" /var/www/html/wp-config.php
fi
