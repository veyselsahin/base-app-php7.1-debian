FROM php:7.1.3-fpm
RUN apt-get -y update && apt-get -y install libpng-dev zip
RUN apt install -y less php7.1 php7.1-fpm php7.1-cli php7.1-mbstring php-mbstring php7.1-mcrypt php-intl php7.1-curl php7.1-gd php7.1-xml zip unzip php7.1-zip php-curl php7.1-mysql php-mysql php-pear php-dev
RUN apt install -y curl nano iputils-ping curl nginx
RUN export DEBIAN_FRONTEND=noninteractive

RUN docker-php-ext-install gd
RUN apt install -y tzdata
RUN ln -fs /usr/share/zoneinfo/Europe/Istanbul /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata
RUN sed -i -e "s/;clear_env\s*=\s*no/clear_env = no/g" /usr/local/etc/php-fpm.d/www.conf







