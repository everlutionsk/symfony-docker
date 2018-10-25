FROM nginx:1.13.7

MAINTAINER Ivan Barlog <ivan.barlog@everlution.sk>

ARG ENV
ARG DOMAIN
ARG USER
ARG PASSWORD

ENV DOMAIN $DOMAIN
ENV USER $USER
ENV PASSWORD $PASSWORD

# Install nginx-extras
RUN apt-get update && apt-get install -y --no-install-recommends \
    nginx-extras

# Remove default nginx site configuration.
RUN rm -rf /etc/nginx/conf.d/default.conf

# Add nginx proxy configuration.
COPY $ENV.conf /etc/nginx/conf.d/proxy.conf

# Add nginx custom config
COPY nginx.conf /etc/nginx/nginx.conf

# Replace domain in virtual host
RUN sed -i "s/{domain}/$DOMAIN/g" /etc/nginx/conf.d/proxy.conf
CMD cat /etc/nginx/conf.d/proxy.conf

# Copy base auth users
COPY base_auth /etc/nginx/.htpasswd
RUN sed -i "s/{user}/$USER/g" /etc/nginx/.htpasswd
RUN sed -i "s/{password}/$PASSWORD/g" /etc/nginx/.htpasswd

# Run nginx in foreground.
CMD ["nginx", "-g", "daemon off;"]
