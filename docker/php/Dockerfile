FROM php:7.2.8-fpm
MAINTAINER Dana Negrescu <dana.negrescu@boxalino.com>

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
    nano \
    ssh \
    git \
    openssl \
    sendmail-bin \
    sendmail \
    g++

# Install and configure libraries and extensions
RUN docker-php-ext-install pdo_mysql \
  && docker-php-ext-install pdo_pgsql \
  && docker-php-ext-configure intl \
  && docker-php-ext-configure hash --with-mhash

RUN docker-php-ext-configure \
   gd --with-freetype-dir=/usr/local/ --with-jpeg-dir=/usr/local/

# Install required extensions
RUN docker-php-ext-install \
    dom \
    simplexml \
    session \
    ctype \
    bcmath \
    gd \
    mbstring \
    intl \
    xsl \
    zip \
    json \
    iconv \
    soap

COPY ./conf/php.ini /usr/local/etc/php/conf.d/php.ini
COPY ./conf/www.conf /usr/local/etc/php-fpm.d/www.conf
COPY ./conf/opcache.ini /usr/local/etc/php/conf.d/opcache.ini

#Installing SSH2
RUN pecl channel-update pecl.php.net
RUN apt-get install -y git libssh2-1 libssh2-1-dev && \
  pecl install ssh2-1.0 && \
  docker-php-ext-enable ssh2

# Install OPCache
RUN docker-php-ext-install opcache && \
    docker-php-ext-enable opcache

# Install Xdebug
RUN pecl install xdebug && \
docker-php-ext-enable xdebug

COPY ./conf/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini


# Install Mailcatcher
RUN apt-get update &&\
    apt-get -y install build-essential ruby-full libsqlite3-dev &&\
    apt-get clean && rm -rf /var/lib/apt/lists/* &&\
    gem install mailcatcher --no-rdoc --no-ri

#Installing APCU
RUN pecl channel-update pecl.php.net \
    && pecl install apcu \
    && docker-php-ext-enable apcu

RUN ln -s /etc/php/mods-available/apcu.ini /usr/local/etc/php/conf.d/20-apcu.ini


# Install ioncube
ADD https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz /tmp/
RUN tar xvzfC /tmp/ioncube_loaders_lin_x86-64.tar.gz /tmp/ \
    && rm /tmp/ioncube_loaders_lin_x86-64.tar.gz \
    && mkdir -p /usr/local/ioncube \
    && cp /tmp/ioncube/ioncube_loader_lin_7.0.so /usr/local/ioncube \
    && rm -rf /tmp/ioncube
COPY ./conf/00-ioncube.ini /usr/local/etc/php/conf.d/00-ioncube.ini

WORKDIR "/var/www/shopware"
VOLUME "/usr/local/etc/php/conf.d"

RUN usermod -u 1001 www-data
EXPOSE 9000

CMD ["php-fpm"]
