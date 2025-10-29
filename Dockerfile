
# Multi-stage Dockerfile for Laravel (PHP-FPM + Nginx)

# Build stage: Composer dependencies
FROM composer:2.7 as vendor
WORKDIR /app
COPY . .
RUN composer install --no-dev --optimize-autoloader

# Production stage: PHP-FPM + Nginx
FROM php:8.2-fpm

# Install system dependencies
RUN apt-get update \
    && apt-get install -y libpq-dev git unzip nginx supervisor \
    && docker-php-ext-install pdo pdo_pgsql

# Copy app files and vendor from build stage
WORKDIR /var/www/html
COPY --from=vendor /app .

# Set permissions
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Copy Nginx config
COPY ./docker/nginx.conf /etc/nginx/nginx.conf

# Copy Supervisor config
COPY ./docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose port 10000 for Render
EXPOSE 10000

# Start Supervisor (runs both PHP-FPM and Nginx)
CMD ["/usr/bin/supervisord"]
