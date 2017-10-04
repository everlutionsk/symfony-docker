FROM php:7.1.9-fpm

COPY app.ini /usr/local/etc/php/conf.d/app.ini
COPY app.pool.conf /usr/local/etc/php/pool.d/app.pool.conf

RUN apt-get update && apt-get install -y --no-install-recommends \
    libmcrypt-dev \
    libicu-dev \
    libcurl4-openssl-dev \
    curl \
    git \
    libpcre3-dev

RUN docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd
RUN docker-php-ext-configure mysqli --with-mysqli=mysqlnd
RUN docker-php-ext-install mcrypt pdo_mysql mysqli intl mbstring opcache

CMD ["php-fpm"]
