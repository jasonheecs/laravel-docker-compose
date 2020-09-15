ARG PHP_VERSION=7.4

FROM jasonheecs/laravel-docker:${PHP_VERSION}

LABEL name="jasonheecs/laravel-docker-compose"
LABEL version="1.0.0"
LABEL maintainer="hello@jasonhee.com"

COPY php/xdebug.ini /usr/local/etc/php/conf.d/
RUN mv /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini

RUN set -ex \
    && apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug

RUN set -ex \
    && composer global require hirak/prestissimo \
    && composer global require laravel/installer

RUN apk del -f .build-deps
