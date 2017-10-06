Feel free to add chunks of code to fpm Dockerfile if you need to install additional libraries.
Default fpm Dockerfile contains minimum libraries needed to run symfony application.

```
RUN apt-get install -y --no-install-recommends \
    libfreetype6-dev \
    libjpeg-dev \
    libpng12-dev \
    libxrender1 \
    libxtst6
    
RUN docker-php-ext-configure gd --enable-gd-native-ttf --with-jpeg-dir=/usr/lib/x86_64-linux-gnu --with-png-dir=/usr/lib/x86_64-linux-gnu --with-freetype-dir=/usr/lib/x86_64-linux-gnu
RUN docker-php-ext-install exif gd

RUN pecl install imagick && docker-php-ext-enable imagick
```
