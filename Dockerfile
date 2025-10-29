# Use official PHP image with required extensions
FROM php:8.2-fpm

# Install system dependencies
RUN apt-get update \
    && apt-get install -y libpq-dev git unzip \
    && docker-php-ext-install pdo pdo_pgsql

# Install Composer
COPY --from=composer:2.7 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy application files
COPY . .

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Set permissions
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Expose port 8000
EXPOSE 8000

# Start the Laravel server with migration and seeding
CMD php artisan migrate --seed --force && php artisan serve --host 0.0.0.0 --port 8000
