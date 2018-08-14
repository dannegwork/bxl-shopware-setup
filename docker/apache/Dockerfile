FROM httpd:2.4
MAINTAINER Dana Negrescu "dana.negrescu@boxalino.com"

# Configure Apache
COPY conf/default-bxl.conf /etc/apache2/sites-available/000-default.conf
#RUN a2enmod rewrite \
#    && sed --in-place "s/^upload_max_filesize.*$/upload_max_filesize = 10M/" /etc/php/7.0/apache2/php.ini \
#    && sed --in-place "s/^memory_limit.*$/memory_limit = 256M/" /etc/php/7.0/apache2/php.ini \
#    && phpenmod mcrypt


COPY ./bin/start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

RUN a2enmod rewrite
RUN mkdir ~/.ssh && touch ~/.ssh/known_hosts && chmod 644 ~/.ssh/known_hosts && eval $(ssh-agent -s)

ENV APACHE_LOCK_DIR         /var/lock/apache2
ENV APACHE_RUN_DIR          /var/run/apache2
ENV APACHE_PID_FILE         ${APACHE_RUN_DIR}/apache2.pid
ENV APACHE_LOG_DIR          /var/log/apache2
ENV APACHE_RUN_USER         www-data
ENV APACHE_RUN_GROUP        www-data
ENV APACHE_MAX_REQUEST_WORKERS 32
ENV APACHE_MAX_CONNECTIONS_PER_CHILD 1024
ENV APACHE_ALLOW_OVERRIDE   None
ENV APACHE_ALLOW_ENCODED_SLASHES Off
ENV APACHE_DISABLE_ACCESS_LOG ""
ENV PHP_TIMEZONE            UTC
ENV PHP_MBSTRING_FUNC_OVERLOAD 0
ENV PHP_NEWRELIC_LICENSE_KEY    ""
ENV PHP_NEWRELIC_APPNAME        ""
ENV PHP_NEWRELIC_FRAMEWORK      "no_framework"

WORKDIR /var/www/shopware
EXPOSE 80 443

USER www-data
#CMD ["/usr/local/bin/start.sh"]
CMD ["apache2-foreground"]