# Create common base image for dev and prod
FROM php:7.4-fpm-alpine as common

LABEL name="jasonheecs/laravel-docker-compose"
LABEL version="1.0.0"
LABEL maintainer="hello@jasonhee.com"

RUN set -ex \
  && apk add --no-cache libpq libzip-dev \
  && apk add --no-cache --virtual .build-deps \
    postgresql-dev

RUN docker-php-ext-install \
    bcmath \
    pdo \
    pdo_mysql \
    pdo_pgsql \
    zip

ENV COMPOSER_HOME /composer
ENV PATH ./vendor/bin:/composer/vendor/bin:$PATH
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer

RUN apk del -f .build-deps

WORKDIR /var/www

# Image for development environments
FROM common AS dev

COPY php/xdebug.ini /usr/local/etc/php/conf.d/

RUN set -ex \
    && apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug

RUN set -ex \
    && composer global require hirak/prestissimo \
    && composer global require laravel/installer

RUN apk del -f .build-deps