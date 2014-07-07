# DOCKER-VERSION 1.0.1
FROM        tchak2k/apache2-php5:latest

RUN         apt-get update
RUN	apt-get install -y rtorrent
RUN	apt-get install -y subversion
RUN apt-get install -y libapache2-mod-scgi


RUN mkdir -p /data/session && mkdir -p /data/download && mkdir -p /data/complete

RUN echo "SCGIMount /RPC2 127.0.0.1:5000" >> /etc/apache2/conf-available/scgi.conf
RUN a2enconf scgi


ADD rtorrent.sv.conf /etc/supervisor/conf.d/rtorrent.sv.conf
ADD rtorrent.rc /root/.rtorrent.rc

EXPOSE 5000

RUN svn checkout http://rutorrent.googlecode.com/svn/trunk/ /var/www/html

RUN chmod -R ugo+w /var/www/html/rutorrent/share
