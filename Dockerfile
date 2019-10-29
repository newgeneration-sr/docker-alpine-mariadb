FROM dotriver/alpine-s6

ENV ROOT_PASSWORD=password
ENV DAILY_BACKUPS=FULL

RUN set -x \
    && apk add --no-cache mariadb  mariadb-client nginx php7-fpm php7-session php7-mbstring phpmyadmin \
    && rm /etc/nginx/conf.d/default.conf \
    && mkdir /run/nginx \
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