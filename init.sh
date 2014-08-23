#!/bin/bash

if [[ ! -f /.rtorrent_configured ]]; then
	#configure rtorrent
 	echo "SCGIMount /$RPC_MOUNT 0.0.0.0:$RPC_PORT" >> /etc/apache2/conf-available/scgi.conf
	a2enconf scgi
	a2enmod scgi
	sed "s/$scgi_port = 5000;/$scgi_port = $RPC_PORT;/g" /var/www/rutorrent/conf/config.php > /var/www/rutorrent/conf/config_temp.php && mv /var/www/rutorrent/conf/config_temp.php /var/www/rutorrent/conf/config.php
	
	sed "s/scgi_port = 0.0.0.0:5000/scgi_port = 0.0.0.0:$RPC_PORT/g" /root/.rtorrent.rc  > /root/.rtorrent.rc.tmp && mv /root/.rtorrent.rc.tmp /root/.rtorrent.rc && rm /root/.rtorrent.rc.tmp
	


	touch /.rtorrent_configured


fi

if [[ ! -d /data/session ]]; then
	mkdir -p /data/session
fi

if [[ ! -d /data/complete ]]; then
	mkdir -p /data/complete
fi

if [[ ! -d /data/download ]]; then
	mkdir -p /data/download
fi

if [[ ! -d /data/auto ]]; then
	mkdir -p /data/auto
fi

supervisord -c /etc/supervisor/supervisor.conf