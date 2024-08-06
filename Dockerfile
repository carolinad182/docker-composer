FROM php:8.2-cli-alpine3.18

RUN apk update \
    && apk add linux-headers \
    && apk add --no-cache --virtual .build-dependencies zip zlib-dev libzip-dev libpng-dev \
    && php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin --filename=composer \
    && apk del .build-dependencies \
    && docker-php-ext-install sockets bcmath \
    && apk add --no-cache git \
    && apk add --no-cache zip libzip-dev \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip \
    && apk add --no-cache libpng libpng-dev \
    && docker-php-ext-install gd \
    && apk del libpng-dev \
    && docker-php-ext-install sockets \
    && apk add --no-cache patch

COPY ./custom.ini /usr/local/etc/php/conf.d/

WORKDIR /app

RUN composer self-update 2.7.2

ENTRYPOINT ["composer"]