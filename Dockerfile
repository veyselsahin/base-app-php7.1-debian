FROM php:7.1.3-fpm
RUN apt-get -y update && apt-get -y install libpng-dev zip unzip curl nano iputils-ping curl nginx less php-pear elinks
RUN export DEBIAN_FRONTEND=noninteractive

RUN docker-php-ext-install gd
RUN apt install -y tzdata
RUN ln -fs /usr/share/zoneinfo/Europe/Istanbul /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata
RUN sed -i -e "s/;clear_env\s*=\s*no/clear_env = no/g" /usr/local/etc/php-fpm.d/www.conf
