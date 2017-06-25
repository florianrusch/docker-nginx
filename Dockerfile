FROM nginx:alpine

MAINTAINER Florian Rusch <dev@florianrusch.de>


# Updating the system
RUN apk update && \
    apk upgrade

RUN rm -rf /var/cache/apk/* && rm -rf /tmp/*


# Configure nginx + php + symfony
ADD nginx.conf /etc/nginx/sites-available/default
ADD php_params /etc/nginx/php_params
RUN echo "upstream php-upstream {server php:9001; }" > /etc/nginx/conf.d/upstream.conf


CMD ["nginx", "-g", "daemon off;"]


EXPOSE 80
EXPOSE 443