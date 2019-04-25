FROM php:7.1.3-fpm
RUN echo "deb [check-valid-until=no] http://cdn-fastly.deb.debian.org/debian jessie main" > /etc/apt/sources.list.d/jessie.list
RUN echo "deb [check-valid-until=no] http://archive.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list
RUN sed -i '/deb http:\/\/deb.debian.org\/debian jessie-updates main/d' /etc/apt/sources.list
RUN apt-get -o Acquire::Check-Valid-Until=false update && apt-get -y install libpng-dev php-zip zip unzip curl nano iputils-ping curl nginx less php-pear elinks software-properties-common apt-transport-https lsb-release ca-certificates wget libmcrypt-dev mcrypt git
RUN export DEBIAN_FRONTEND=noninteractive

RUN docker-php-ext-install gd mysqli pdo_mysql mcrypt zip
RUN docker-php-ext-enable gd mysqli pdo_mysql mcrypt
RUN apt install -y tzdata
RUN ln -fs /usr/share/zoneinfo/Europe/Istanbul /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata
RUN sed -i -e "s/;clear_env\s*=\s*no/clear_env = no/g" /usr/local/etc/php-fpm.d/www.conf
RUN yes | pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/no-debug-non-zts-20160303/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> //usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.max_nesting_level=30000" >> //usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini
