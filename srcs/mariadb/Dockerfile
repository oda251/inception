FROM debian:bullseye-slim
VOLUME /var/lib/mysql

RUN apt update -y && apt upgrade -y \
    && apt install -y mariadb-server

RUN mkdir -p /var/run/mysqld \
    && chown -R mysql:mysql /var/run/mysqld \
    && chmod 777 /var/run/mysqld \
    && chmod 777 -R /var/lib/mysql

COPY ./mariadb.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./init.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh

EXPOSE 3306

ENTRYPOINT [ "sh", "/docker-entrypoint.sh" ]