FROM php:7.4.16-cli-alpine

RUN apk update
RUN apk add --no-cache --virtual .build-dependencies zip zlib-dev libzip-dev
RUN php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin --filename=composer
RUN apk del .build-dependencies
RUN docker-php-ext-install sockets bcmath
RUN apk add --no-cache git

COPY ./custom.ini /usr/local/etc/php/conf.d/

WORKDIR /app

RUN composer self-update 2.0.11

ENTRYPOINT ["composer"]
