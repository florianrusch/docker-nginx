FROM nginx:alpine

MAINTAINER Florian Rusch <dev@florianrusch.de>


# Updating the system
RUN apk update && \
    apk upgrade && \
    apk add bash git unzip && \
    rm -rf /var/cache/apk/* /tmp/* /usr/share/man


# Configure nginx + php + symfony
ADD nginx.conf /etc/nginx/conf.d/default.conf
RUN echo "upstream php-upstream {server php:9001; }" > /etc/nginx/conf.d/upstream.conf


CMD ["nginx", "-g", "daemon off;"]

WORKDIR /usr/share/nginx/html/symfony

EXPOSE 80
EXPOSE 443