FROM php:cli

COPY app.ini /usr/local/etc/php/conf.d/app.ini

RUN apt-get update && apt-get install -y --no-install-recommends \
    libfreetype6-dev \
    libjpeg-dev \
    libmcrypt-dev \
    libpng12-dev \
    libxrender1 \
    libxtst6 \
    libicu-dev \
    libcurl4-openssl-dev \
    zlib1g-dev \
    curl \
    git \
    && docker-php-ext-install mcrypt \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
    && docker-php-ext-configure mysqli --with-mysqli=mysqlnd \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install intl \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install exif \
    && docker-php-ext-configure gd --enable-gd-native-ttf --with-jpeg-dir=/usr/lib/x86_64-linux-gnu --with-png-dir=/usr/lib/x86_64-linux-gnu --with-freetype-dir=/usr/lib/x86_64-linux-gnu \
    && docker-php-ext-install gd \
    && docker-php-ext-install opcache \
    && docker-php-ext-install zip \
    && docker-php-ext-install pcntl

# install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN usermod -u 1000 www-data
