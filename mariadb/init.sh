#!/bin/bash

chown -R mysql:mysql /var/lib/mysql
chown -R mysql:mysql /var/run/mysqld

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

mysqld & sleep 5

chmod 777 -R /var/run/mysqld

# 通常ユーザーの作成
echo "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';" | mysql -u root -p${MYSQL_ROOT_PASSWORD}
echo "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';" | mysql -u root -p${MYSQL_ROOT_PASSWORD}

# rootユーザーのリモートアクセス設定
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" | mysql -u root -p${MYSQL_ROOT_PASSWORD}
echo "FLUSH PRIVILEGES;" | mysql -u root -p${MYSQL_ROOT_PASSWORD}

echo "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};" | mysql -u root -p${MYSQL_ROOT_PASSWORD}

killall mysqld
exec mysqld
chmod 777 -R /var/run/mysqld