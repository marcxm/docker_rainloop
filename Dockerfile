FROM debian:stable-slim

MAINTAINER "Marc Smith" <marc_smith@gmx.com>

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root
RUN apt-get update
RUN apt-get install -y apache2 php php-curl php-dompdf php-fdomdocument curl wget unzip
ADD etc/apache2/apache2.conf /etc/apache2/apache2.conf
ADD etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf
ADD start.sh /start.sh
RUN chmod +x /start.sh
RUN wget https://www.rainloop.net/repository/webmail/rainloop-community-latest.zip -P /var/www/html
RUN unzip /var/www/html/rainloop-community-latest.zip -d /var/www/html
RUN rm -f /var/www/html/rainloop-community-latest.zip
RUN chown -R www-data:www-data /var/www/
RUN chown -R www-data:www-data /var/www/html
RUN chown -R www-data:www-data /var/www/html/*
RUN cd /var/www/html && find . -type d -exec chmod 755 {} \;
RUN cd /var/www/html && find . -type f -exec chmod 644 {} \;
RUN rm /var/www/html/index.html
CMD ["/start.sh"]
EXPOSE 80
VOLUME /var/www/html
