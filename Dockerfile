FROM php:7.3.20-cli-alpine

RUN apk update \
    && apk add --no-cache --virtual .build-dependencies zip zlib-dev libzip-dev \
    && php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin --filename=composer \
    && apk del .build-dependencies \
    && apk add --no-cache git

COPY ./custom.ini /usr/local/etc/php/conf.d/

WORKDIR /app

RUN composer self-update 1.9.1

ENTRYPOINT ["composer"]
