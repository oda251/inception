FROM debian:bullseye-slim

RUN apt update -y && apt upgrade -y \
    && apt install -y mariadb-server

RUN mkdir -p /var/run/mysqld \
    && chown -R mysql:mysql /var/run/mysqld \
    && chmod 777 /var/run/mysqld

COPY ./mariadb.cnf /etc/mysql/mariadb.cnf.d/50-server.cnf
COPY ./init.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh

EXPOSE 3306

ENTRYPOINT [ "sh", "/docker-entrypoint.sh" ]