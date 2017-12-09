FROM everlutionsk/fpm:7.1.12

MAINTAINER Ivan Barlog <ivan.barlog@everlution.sk>

# Configure xdebug
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug
COPY ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

CMD ["php-fpm"]
