# DOCKER-VERSION 1.0.1
FROM        tchak2k/apache-php5:latest

RUN         apt-get update
RUN	apt-get install -y rtorrent
RUN	apt-get install -y subversion
RUN apt-get install -y libapache2-mod-scgi
RUN apt-get install -y openssl

RUN mkdir -p /data/session && mkdir -p /data/download && mkdir -p /data/complete

RUN echo "SCGIMount /RPC2 0.0.0.0:5000" >> /etc/apache2/conf-available/scgi.conf
RUN a2enconf scgi

RUN a2enmod ssl
RUN a2enmod auth_digest
RUN a2enmod scgi

ADD rtorrent.sv.conf /etc/supervisor/conf.d/rtorrent.sv.conf
ADD rtorrent.rc /root/.rtorrent.rc

ADD default /etc/apache2/sites-available/000-default.conf

ADD default-ssl /etc/apache2/sites-available/default-ssl.conf

ADD passwords /etc/apache2/passwords


RUN openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com"   -out /etc/apache2/apache.pem -keyout /etc/apache2/apache.pem 


RUN chmod 600 /etc/apache2/apache.pem



RUN svn checkout http://rutorrent.googlecode.com/svn/trunk/ /var/www

RUN chmod -R ugo+w /var/www/rutorrent/share


RUN a2ensite default-ssl
