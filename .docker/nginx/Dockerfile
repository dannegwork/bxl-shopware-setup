FROM nginx:1.17.8
LABEL maintainer="dana@boxalino.com"

RUN apt-get update && apt-get install -y \
    curl \
    nano \
    procps \
    iputils-ping


COPY ./conf/nginx.conf /etc/nginx/
COPY ./conf/sites-enabled/dev-shpw6-comm.danneg.com.conf /etc/nginx/sites-enabled/dev-shpw6-comm.danneg.com.conf
COPY ./conf/sites-available/dev-shpw6-comm.danneg.com.conf /etc/nginx/sites-available/dev-shpw6-comm.danneg.com.conf

WORKDIR /var/www/shopware
EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]