FROM debian:bullseye-slim
VOLUME /var/www/html

RUN apt-get update && apt-get install -y \
    php7.4 \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-curl \
    php7.4-gd \
    php7.4-intl \
    php7.4-mbstring \
    php7.4-soap \
    php7.4-xml \
    php7.4-zip \
    wget \
    curl \
    mariadb-client

RUN sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf && \
    sed -i 's/;listen.allowed_clients = 127.0.0.1/listen.allowed_clients = 0.0.0.0/g' /etc/php/7.4/fpm/pool.d/www.conf

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp && \
    wp cli update

RUN mkdir /run/php && \
    mkdir -p /var/www/html && \
    chmod -R 777 /var/www/html


COPY ./init.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT [ "sh", "/docker-entrypoint.sh" ]

EXPOSE 9000

CMD ["php-fpm7.4", "-F"]