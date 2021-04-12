#!/bin/bash

echo "instalation paquets APT"
apt update
apt install -y mariadb-server mariadb-client
apt install -y php apache2 libapache2-mod-php php-mysql php-xml
apt install -y composer vim git snapd

echo "Config snapd + certbot"
snap install core
snap refresh core
snap install --classic certbot

CERTBOT=$(ls /usr/bin | grep certbot)
if [ -z "$CERTBOT" ]
then
	        echo" on cree le lien /usr/bin/certbot
		ln -s /snap/bin/certbot /usr/bin/certbot
fi



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

echo "Penser a taper la commander certbot --apache"





# avec dieze on fait commentaire
