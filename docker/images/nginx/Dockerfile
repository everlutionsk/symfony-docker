FROM nginx:1.13.0

ARG ENV=dev
ARG DOMAIN=dev.symfony

ENV DOMAIN $DOMAIN

# Remove default nginx site configuration.
RUN rm -rf /etc/nginx/conf.d/default.conf

# Add nginx proxy configuration.
COPY $ENV.conf /etc/nginx/conf.d/proxy.conf

RUN sed -i "s/{domain}/$DOMAIN/g" /etc/nginx/conf.d/proxy.conf
CMD cat /etc/nginx/conf.d/proxy.conf

# Run nginx in foreground.
CMD ["nginx", "-g", "daemon off;"]


