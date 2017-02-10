FROM ubuntu:xenial

RUN apt-get update && apt-get install -y \
    nginx

ADD nginx.conf /etc/nginx/

ADD symfony.conf /etc/nginx/sites-available/

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN ln -s /etc/nginx/sites-available/symfony.conf /etc/nginx/sites-enabled/symfony

RUN rm /etc/nginx/sites-enabled/default

RUN usermod -u 1000 www-data

CMD ["nginx"]

EXPOSE 80
EXPOSE 443
