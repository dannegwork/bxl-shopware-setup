FROM nginx:1.15
MAINTAINER Dana Negrescu <dana.negrescu@boxalino.com>

RUN apt-get update && apt-get install -y \
    curl \
    nano \
    procps \
    iputils-ping

COPY ./conf/nginx.conf /etc/nginx/
COPY ./conf/sites-enabled/default.shopware.conf /usr/local/bin/nginx/sites-enabled/default.shopware.conf
COPY ./bin/start.sh /usr/local/bin/start.sh

RUN chmod +x /usr/local/bin/start.sh

WORKDIR /var/www/shopware
EXPOSE 80 443

CMD ["/usr/local/bin/start.sh"]