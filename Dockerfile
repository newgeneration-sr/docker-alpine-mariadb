FROM dotriver/alpine-s6

ENV ROOT_PASSWORD=password
ENV DAILY_BACKUPS=FULL

RUN sed -i "s/v3.12/v3.18/g" /etc/apk/repositories &&\
    apk --no-cache add --upgrade apk-tools alpine-keys --allow-untrusted &&\
    apk --no-cache upgrade --available && \
    sed -i "s/v3.18/latest-stable/g" /etc/apk/repositories &&\
    apk --no-cache add --upgrade apk-tools alpine-keys --allow-untrusted &&\
    apk --no-cache upgrade --available

RUN apk add --no-cache mariadb mariadb-client nginx php83-fpm php83-session php83-mbstring phpmyadmin \
    && rm /etc/nginx/http.d/* \
    && mkdir /run/nginx -p \
    && chown nginx:nginx /run/nginx \
    && mkdir /run/mysqld/ /var/log/mysql -p \
    && chown mysql:mysql /run/mysqld  /var/log/mysql

    
ADD conf/ /

RUN set -x \
    && chown -R nginx:nginx /etc/phpmyadmin \
    && chmod +x /usr/local/bin/ -R \
    && chmod +x /etc/cont-init.d/ -R \
    && chmod +x /etc/periodic/ -R  \
    && chmod +x /etc/s6/services/ -R 