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
  -subj "/C=JA/ST=Tokyo/L=Shinjuku/O=42/CN=name"

COPY ./default.conf /etc/nginx/sites-available/default

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
  && ln -sf /dev/stderr /var/log/nginx/error.log 

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]