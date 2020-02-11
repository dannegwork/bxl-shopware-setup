FROM php:7.4.2-fpm
LABEL maintainer="dana@boxalino.com"

# install libs according to Shopware6 documentation&requirements
RUN apt-get update && apt-get install -y \
    cron \
    libmemcached-dev \
    libssl-dev \
    libz-dev \
    libmemcached11 \
    libmcrypt-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libpq-dev \
    zlib1g-dev \
    libicu-dev \
    libxslt-dev \
    libjpeg-dev \
    libssl-dev \
    libmcrypt-dev \
    libxml2-dev \
    libzip-dev \
    curl \
    wget \
    unzip \
    nano \
    ssh \
    git \
    openssl \
    sendmail-bin \
    sendmail \
    libonig-dev \
    g++

# Install and configure libraries and extensions
RUN docker-php-ext-install pdo_mysql \
  && docker-php-ext-install pdo_pgsql \
  && docker-php-ext-configure intl \
  && docker-php-ext-configure hash --with-mhash

# Install required extensions
RUN docker-php-ext-install bcmath \
    gd \
    mbstring \
    intl \
    xsl \
    zip \
    iconv \
    dom \
    fileinfo \
    json \
    soap

COPY ./conf/www.conf /usr/local/etc/php-fpm.d/www.conf
COPY ./conf/opcache.ini /usr/local/etc/php/conf.d/opcache.ini

#Installing SSH2
RUN pecl channel-update pecl.php.net
#RUN cd /tmp \
#    && git clone https://git.php.net/repository/pecl/networking/ssh2.git \
#    && cd /tmp/ssh2/ \
#    && .travis/build.sh \
#    && docker-php-ext-enable ssh2

# Install OPCache
RUN docker-php-ext-install opcache && \
    docker-php-ext-enable opcache

# Install ioncube -- it should load before xDebug
ADD https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz /tmp/
RUN tar xvzfC /tmp/ioncube_loaders_lin_x86-64.tar.gz /tmp/ \
    && rm /tmp/ioncube_loaders_lin_x86-64.tar.gz \
    && mkdir -p /usr/local/ioncube \
    && cp /tmp/ioncube/ioncube_loader_lin_7.0.so /usr/local/ioncube \
    && rm -rf /tmp/ioncube
COPY ./conf/00-ioncube.ini /usr/local/etc/php/conf.d/00-ioncube.ini

# Install Xdebug
RUN pecl install xdebug

COPY ./conf/php.ini /usr/local/etc/php/conf.d/php.ini
COPY ./conf/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

RUN  docker-php-ext-enable xdebug

# Install Mailcatcher
RUN apt-get update &&\
    apt-get -y install build-essential ruby-full libsqlite3-dev &&\
    apt-get clean && rm -rf /var/lib/apt/lists/* &&\
    gem install mailcatcher --no-rdoc --no-ri

# Install Redis for PHP:
RUN pecl install redis-3.1.2 \
    &&  rm -rf /tmp/pear \
    &&  docker-php-ext-enable redis

RUN apt-get update &&\
    apt-get -y install build-essential ruby-full libsqlite3-dev &&\
    apt-get clean && rm -rf /var/lib/apt/lists/* &&\
    gem install mailcatcher --no-rdoc --no-ri

#Installing APCU
RUN pecl channel-update pecl.php.net \
    && pecl install apcu \
    && docker-php-ext-enable apcu

RUN ln -s /etc/php/mods-available/apcu.ini /usr/local/etc/php/conf.d/20-apcu.ini

WORKDIR "/var/www/shopware"
VOLUME "/usr/local/etc/php/conf.d"

RUN usermod -u 1001 www-data
EXPOSE 9000

CMD ["php-fpm"]
