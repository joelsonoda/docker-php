FROM debian:jessie-slim

MAINTAINER jsonoda@getmealticket.com

RUN apt-get update && \
    apt-get install -y nginx php5-fpm php5-cli php5-mysql php5-mcrypt php5-imagick php5-xdebug curl php5-curl rsyslog rsyslog-gnutls runit && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Setup runit services
ADD service /etc/service
RUN find /etc/service -type f -name run -exec chmod +x {} \;

# Setup php5
# Adjust some of the limits for php
ADD cli-php.ini /etc/php5/cli/php.ini
ADD fpm-php.ini /etc/php5/fpm/php.ini
RUN rm -f /etc/php5/fpm/conf.d/*xdebug.ini
RUN rm -f /etc/php5/cli/conf.d/*xdebug.ini
RUN rm -f /etc/php5/fpm/pool.d/*
ADD www-php5-pool.conf /etc/php5/fpm/pool.d/
ADD php-fpm.conf /etc/php5/fpm/php-fpm.conf

RUN mkdir -p /etc/rsyslog.d/keys/ca.d

#ENV APP_ROOT=application

CMD ["/usr/bin/runsvdir", "-P", "/etc/service"]
