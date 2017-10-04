FROM php:7.1.9-fpm

RUN apt-get update && apt-get install -y --no-install-recommends \
    libmcrypt-dev \
    libicu-dev \
    libcurl4-openssl-dev \
    curl \
    git \
    libpcre3-dev \
    locales

RUN docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd
RUN docker-php-ext-configure mysqli --with-mysqli=mysqlnd
RUN docker-php-ext-install mcrypt pdo_mysql mysqli intl mbstring opcache

# Reconfigure locales
RUN locale-gen en_US en_US.UTF-8 sk_SK sk_SK.UTF-8
RUN dpkg-reconfigure -f noninteractive locales

COPY app.ini /usr/local/etc/php/conf.d/app.ini
COPY app.pool.conf /usr/local/etc/php/pool.d/app.pool.conf

CMD ["php-fpm"]
