FROM nginx:1.15
MAINTAINER Dana Negrescu <dana.negrescu@boxalino.com>

RUN apt-get update && apt-get install -y \
    curl \
    nano \
    procps \
    iputils-ping

COPY ./conf/nginx.conf /etc/nginx/
COPY ./conf/sites-enabled/shpw.bxl.com.conf /etc/nginx/sites-enabled/shpw.bxl.com.conf
COPY ./conf/sites-available/shpw.bxl.com.conf /etc/nginx/sites-available/shpw.bxl.com.conf

WORKDIR /var/www/shopware
EXPOSE 80 443
