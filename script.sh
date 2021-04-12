#!/bin/bash

echo "instalation paquets APT"
apt update
apt install mariadb-server mariadb-client
apt install php apache2 libapache2-mod-php php-mysql php-xml
apt install composer vim git
#je dois comparer deux numero ,on recoupere identifiant par md5sum de notre 000-default.conf
#on le mettre dans variable du coup MD5_DEST et MD5_SRC
MD5_DEST=$(md5sum /etc/apache2/sites-available/000-default.conf | awk '{print $1}')
MD5_SRC=$(md5sum 000-default.conf |awk '{print $1}')
if [ "$MD5_DEST" != "$MD5_SRC" ]
then
	        echo"on ecrase la conf apache"
		        cp 000-default.conf /etc/apache2/sites-available/000-default.conf
			        service apache2 restart
				fi

echo "Pull source git"

cd /var/www/html
git pull origin master
composer install
chown -R www-data:www-data /var/www/html/
source .env.dev







# avec dieze on fait commentaire
