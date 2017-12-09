FROM php:7.1.12-cli

MAINTAINER Ivan Barlog <ivan.barlog@everlution.sk>

RUN apt-get update && apt-get install -y --no-install-recommends \
    libmcrypt-dev \
    libicu-dev \
    libcurl4-openssl-dev \
    curl \
    git \
    zlib1g-dev \
    libpcre3-dev \
    locales \
    vim

RUN docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd
RUN docker-php-ext-configure mysqli --with-mysqli=mysqlnd
RUN docker-php-ext-install mcrypt pdo_mysql mysqli intl mbstring zip pcntl

# Reconfigure locales
RUN locale-gen en_US en_US.UTF-8 sk_SK sk_SK.UTF-8
RUN dpkg-reconfigure -f noninteractive locales

# Add composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN usermod -u 1000 www-data

CMD ["php", "-a"]
