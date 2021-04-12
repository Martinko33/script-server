#!/bin/bash

CERTBOT=$(ls /usr/bin | grep certbot)
if [ -z "$CERTBOT" ]
then
	echo" on cree le lien /usr/bin/certbot
	ln -s /snap/bin/certbot /usr/bin/certbot
fi
