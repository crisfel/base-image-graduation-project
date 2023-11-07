#FROM php:8.0-fpm

#RUN apt-get update && apt-get install -y \
    #git \
    #curl \
    #libpng-dev \
    #libonig-dev \
    #libxml2-dev \
    #zip \
    #unzip

#RUN apt-get update && \
    #apt-get install -y docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/

#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#RUN docker-php-ext-install pdo_mysql mbstring gd


#WORKDIR /app
#COPY composer.json .
#RUN composer install --no-scripts
#RUN composer update
#COPY . .
#CMD php artisan serve --host=0.0.0.0 --port 80

# Used for prod build.
FROM php:8.1-fpm as php

# Set environment variables
ENV PHP_OPCACHE_ENABLE=1
ENV PHP_OPCACHE_ENABLE_CLI=0
ENV PHP_OPCACHE_VALIDATE_TIMESTAMPS=0
ENV PHP_OPCACHE_REVALIDATE_FREQ=0

# Install dependencies.
RUN apt-get update && apt-get install -y unzip libpq-dev libcurl4-gnutls-dev nginx libonig-dev

# Install PHP extensions.
RUN docker-php-ext-install mysqli pdo pdo_mysql bcmath curl opcache mbstring

# Copy composer executable.
COPY --from=composer:2.3.5 /usr/bin/composer /usr/bin/composer
