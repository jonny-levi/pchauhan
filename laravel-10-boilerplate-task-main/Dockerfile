FROM php:8.2
ARG queueTimeout
ARG queueTries
ARG queues

ENV QUEUE_TIMEOUT=${queueTimeout}
ENV QUEUE_TRIES=${queueTries}
ENV QUEUES=${queues}

RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

#RUN docker-php-ext-install mysqli pdo pdo_mysql && docker-php-ext-enable pdo_mysql

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www

COPY . .

# Ensure permissions for Laravel storage and cache
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache
# Install the Laravel dependencies

RUN composer install --no-dev --optimize-autoloader

# test: php artisan queue:work redis --queue=default --once
CMD php artisan queue:work redis --queue=${QUEUES} --timeout=${QUEUE_TIMEOUT} --tries=${QUEUE_TRIES} 