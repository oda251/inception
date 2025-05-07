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
    sed -i 's/^;*log_level = .*/log_level = debug/' /etc/php/7.4/fpm/php-fpm.conf && \
    sed -i 's|^;*error_log = .*|error_log = /proc/self/fd/2|' /etc/php/7.4/fpm/pool.d/www.conf && \
    sed -i 's/;catch_workers_output = yes/catch_workers_output = yes/g' /etc/php/7.4/fpm/pool.d/www.conf

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp && \
    wp cli update

WORKDIR /var/www/html

RUN mkdir -p /run/php && \
    mkdir -p /var/www/html && \
    chmod -R 777 /var/www/html

COPY ./init.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
EXPOSE 9000
ENTRYPOINT [ "sh", "/docker-entrypoint.sh" ]
