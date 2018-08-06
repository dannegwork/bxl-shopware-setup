FROM php:7.0.20-cli
MAINTAINER Dana Negrescu <dana.negrescu@boxalino.com>

RUN apt-get update && apt-get install -y \
    cron \
    libmemcached-dev \
    libssl-dev \
    libz-dev \
    libmemcached11 \
    libmcrypt-dev \
    libjpeg62-turbo-dev \
    libpng12-dev \
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
    dom \
    nano \
    ssh \
    libssh2-1-dev \
    libssh2-php \
    git \
    openssl \
    sendmail-bin \
    sendmail\
    g++

# Install and configure libraries and extensions
RUN docker-php-ext-install mcrypt \
  && docker-php-ext-install pdo_mysql \
  && docker-php-ext-install pdo_pgsql \
  && docker-php-ext-configure intl \
  && docker-php-ext-configure hash --with-mhash

RUN docker-php-ext-configure \
   gd --with-freetype-dir=/usr/local/ --with-jpeg-dir=/usr/local/

# Install required extensions
RUN docker-php-ext-install \
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


# Get composer installed to /usr/local/bin/composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
COPY .composer/auth.json /root/.composer/auth.json

ADD magento/bin/* /usr/local/bin/
RUN chmod +x /usr/local/bin/install
RUN chmod +x /usr/local/bin/command
RUN chmod +x /usr/local/bin/environment_magento

COPY bin/environment /usr/local/bin/
COPY bin/install /usr/local/bin/
RUN chmod +x /usr/local/bin/environment
RUN chmod +x /usr/local/bin/install

WORKDIR /var/www/shopware

RUN usermod -u 1000 www-data
RUN usermod -G 100 www-data

ENTRYPOINT ["/usr/local/bin/environment"]
CMD ["bash"]