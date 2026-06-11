FROM debian:12-slim

WORKDIR /var/www/wordpress

RUN apt update -y && apt upgrade -y && apt install -y curl \
    php-fpm \
    php-mysql \
    php-cli \
    php-gd \
    php-curl \
    php-mbstring \
    php-xml \
    php-zip \
    php-opcache 

COPY ./setup/setup.sh /tmp/setup.sh

RUN  sed -i 's/listen = \/run\/php\/php8.2-fpm.sock/listen = 0.0.0.0:9000/' /etc/php/8.2/fpm/pool.d/www.conf

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    ls && \
    chmod +x wp-cli.phar && \
    cp wp-cli.phar /usr/local/bin/wp

CMD [ "bash", "/tmp/setup.sh" ]
