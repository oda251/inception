FROM debian:bullseye-slim

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y \
  nginx \
  openssl \
  curl \
  procps

RUN mkdir -p /etc/ssl/certs \
  && mkdir -p /etc/ssl/private \
  && mkdir -p /var/www/html

RUN openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout /etc/ssl/private/inception.key \
  -out /etc/ssl/certs/inception.crt \
  -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=yoda.42.fr"

RUN chmod 600 /etc/ssl/private/inception.key \
  && chmod 644 /etc/ssl/certs/inception.crt

RUN rm -f /etc/nginx/conf.d/default.conf
RUN rm -f /etc/nginx/sites-enabled/default
COPY ./nginx.conf /etc/nginx/nginx.conf

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
  && ln -sf /dev/stderr /var/log/nginx/error.log 

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
  CMD curl -f http://localhost || exit 1

RUN apt-get clean \
  && rm -rf /var/lib/apt/lists/*

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]