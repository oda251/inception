#!/bin/bash

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

mysqld & sleep 5

echo "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" | mysql -u root -p${MYSQL_ROOT_PASSWORD}
echo "GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" | mysql -u root -p${MYSQL_ROOT_PASSWORD}
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" | mysql -u root -p${MYSQL_ROOT_PASSWORD}
echo "FLUSH PRIVILEGES;" | mysql -u root -p${MYSQL_ROOT_PASSWORD}

echo "CREATE DATABASE ${MYSQL_DATABASE};" | mysql -u root -p${MYSQL_ROOT_PASSWORD}

killall mysqld
exec mysqld