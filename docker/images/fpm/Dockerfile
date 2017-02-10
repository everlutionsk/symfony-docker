FROM php:fpm

COPY app.ini /usr/local/etc/php/conf.d/app.ini
COPY app.pool.conf /usr/local/etc/php/pool.d/app.pool.conf

RUN apt-get update && apt-get install -y --no-install-recommends \
    libfreetype6-dev \
    libjpeg-dev \
    libmcrypt-dev \
    libpng12-dev \
    libxrender1 \
    libxtst6 \
    libicu-dev \
    libcurl4-openssl-dev \
    curl \
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
    && docker-php-ext-install pcntl

# Configure xdebug
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug
COPY ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

RUN usermod -u 1000 www-data

CMD ["php-fpm"]
