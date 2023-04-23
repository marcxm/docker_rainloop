FROM debian:stable-slim

MAINTAINER "Marc Smith" <marc_smith@gmx.com>

ENV VERSION=1.16.0

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root
RUN apt-get update
RUN apt-get update && apt-get install -y apache2 php php-curl php-dompdf php-fdomdocument curl wget unzip
COPY etc/apache2/apache2.conf /etc/apache2/apache2.conf
COPY etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY run.sh /run.sh
RUN chmod +x /run.sh
RUN wget https://www.rainloop.net/repository/webmail/rainloop-latest.zip -P /var/www/html
RUN unzip -o /var/www/html/rainloop-latest.zip -d /var/www/html
RUN rm -f /var/www/html/rainloop-latest.zip
RUN chown -R www-data:www-data /var/www/
RUN chown -R www-data:www-data /var/www/html
RUN chown -R www-data:www-data /var/www/html/*
RUN cd /var/www/html && find . -type d -exec chmod 755 {} \;
RUN cd /var/www/html && find . -type f -exec chmod 644 {} \;
RUN rm /var/www/html/index.html
CMD ["/run.sh"]
EXPOSE 80
