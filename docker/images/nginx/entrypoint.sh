#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# setting PHP FPM source
echo "upstream php-upstream { server $PHPFPM_HOST:$PHPFPM_PORT; }" > /etc/nginx/conf.d/upstream.conf

# find and replace
# sed -i 's/old-word/new-word/g' *.txt
sed -i -e "s@THESERVERNAME@$SYMFONY_SERVERNAME@g" /etc/nginx/sites-available/symfony.conf
sed -i -e "s@THEROOTFOLDER@$SYMFONY_ROOT@g" /etc/nginx/sites-available/symfony.conf

chmod -R 777 $SYMFONY_ROOT/../var/cache
chmod -R 777 $SYMFONY_ROOT/../var/logs
chmod -R 777 $SYMFONY_ROOT/../var/sessions

exec "$@"
