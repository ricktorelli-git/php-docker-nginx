FROM php:8.3-fpm
RUN apt-get update && apt-get install -y \
    git \
    curl \
    sudo \
    zip \
    vim \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    unzip

RUN docker-php-ext-install pdo pdo_mysql
RUN pecl install xdebug && docker-php-ext-enable xdebug

# Copie o arquivo php.ini para o contêiner
COPY php.ini /usr/local/etc/php/

WORKDIR /var/www/html

EXPOSE 9000
