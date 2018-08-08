FROM apache:2.4
MAINTAINER Dana Negrescu "dana.negrescu@boxalino.com"

# Configure Apache
COPY conf/default-bxl.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite \
    && sed --in-place "s/^upload_max_filesize.*$/upload_max_filesize = 10M/" /etc/php/7.0/apache2/php.ini \
    && sed --in-place "s/^memory_limit.*$/memory_limit = 256M/" /etc/php/7.0/apache2/php.ini \
    && phpenmod mcrypt


COPY ./bin/start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

WORKDIR /var/www/shopware
EXPOSE 80 443

RUN a2enmod rewrite
RUN mkdir ~/.ssh && touch ~/.ssh/known_hosts && chmod 644 ~/.ssh/known_hosts && eval $(ssh-agent -s)

USER www-data
#CMD ["/usr/local/bin/start.sh"]
CMD ["apache2-foreground"]