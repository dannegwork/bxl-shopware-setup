FROM nginx:1.15
MAINTAINER Dana Negrescu <dana.negrescu@boxalino.com>

RUN apt-get update && apt-get install -y \
    curl \
    nano \
    procps \
    iputils-ping

COPY conf /etc/nginx/
#COPY conf /usr/local/bin/nginx/sites-enabled/shopware.boxalino.conf
#COPY conf /usr/local/bin/nginx/sites-available/shopware.boxalino.conf
#RUN a2ensite shopware.boxalino.com.conf

WORKDIR /var/www/shopware
EXPOSE 80 443

#CMD ["bash /usr/local/bin/start"]