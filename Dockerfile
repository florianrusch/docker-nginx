FROM nginx:alpine

LABEL maintainer="dev@florianrusch.de"

ADD nginx.conf /etc/nginx/conf.d/default.conf
ADD basic.conf /etc/nginx/conf.d/basic.conf
ADD ssl.conf /etc/nginx/conf.d/ssl.conf
ADD entrypoint.sh /opt/entrypoint.sh

# Updating the system
RUN apk update && \
    apk upgrade && \
    apk add bash openssl && \
    rm -rf /var/cache/apk/* /tmp/* /usr/share/man && \
    rm -rf /etc/nginx/conf.d/*; \
    mkdir -p /etc/nginx/ssl

# Configure nginx + php
RUN echo "upstream php-upstream { server php:9000; }" > /etc/nginx/conf.d/upstream.conf && \
    chmod a+x /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]

WORKDIR /usr/share/nginx/html

EXPOSE 80
EXPOSE 443
