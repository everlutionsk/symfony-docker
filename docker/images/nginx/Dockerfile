FROM nginx:1.13.0

ARG ENV=dev
ARG DOMAIN=dev.symfony
ARG USER=user
ARG PASSWORD=password

ENV DOMAIN $DOMAIN
ENV USER $USER
ENV PASSWORD $PASSWORD

# Remove default nginx site configuration.
RUN rm -rf /etc/nginx/conf.d/default.conf

# Add nginx proxy configuration.
COPY $ENV.conf /etc/nginx/conf.d/proxy.conf

RUN sed -i "s/{domain}/$DOMAIN/g" /etc/nginx/conf.d/proxy.conf
CMD cat /etc/nginx/conf.d/proxy.conf

# copy base auth users
COPY base_auth /etc/nginx/.htpasswd
RUN sed -i "s/{user}/$USER/g" /etc/nginx/.htpasswd
RUN sed -i "s/{password}/$PASSWORD/g" /etc/nginx/.htpasswd

# Run nginx in foreground.
CMD ["nginx", "-g", "daemon off;"]


