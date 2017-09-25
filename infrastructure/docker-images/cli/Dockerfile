FROM php:7.1.9-cli

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
    curl \
    git \
    zlib1g-dev \
    curl \
    libpcre3-dev
 
RUN docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd
RUN docker-php-ext-configure mysqli --with-mysqli=mysqlnd
RUN docker-php-ext-configure gd --enable-gd-native-ttf --with-jpeg-dir=/usr/lib/x86_64-linux-gnu --with-png-dir=/usr/lib/x86_64-linux-gnu --with-freetype-dir=/usr/lib/x86_64-linux-gnu
RUN docker-php-ext-install mcrypt pdo_mysql mysqli intl mbstring gd exif zip pcntl

# Add composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

CMD ["php", "-a"]
