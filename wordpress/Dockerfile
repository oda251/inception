FROM debian:bullseye-slim

RUN apt update -y && apt upgrade -y \
    && apt install php-fpm php-mysql wget -y

COPY ./init.sh /docker-entrypoint.sh

ENTRYPOINT [ "sh", "/docker-entrypoint.sh" ]