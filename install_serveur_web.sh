#################################################
# Script automatisation déploiement serveur web #
#################################################

#!/bin/bash

echo "What are the name of the website (ex: google.fr)"
read nom_serveur
echo "What are your mail adress?"
read mailaddress

#Variable
vhost='/etc/apache2/sites-available/'
cmdsys='systemctl'

## installation des paquets ##
apt update
apt upgrade -y
echo -e "Installation d'apache 2, mysql server, php7 et ses modules, phpmyadmin"
apt install apache2 mariadb-server php7.0 php7.0-mysql phpmyadmin -y

## Fin installation des paquets ##

##Configuration d'Apache2##
#Activation des services
a2enmod ssl
	cp example.website.fr $vhost
	cd $vhost
	cp example.website.fr $nom_serveur.conf
	cp $nom_serveur.conf www.$nom_serveur.conf
	cp 000-default.conf default.save
	sed -i -e "s/localhost/"$nom_serveur"/g" 000-default.conf #remplace le mot "localhost" par $nom_serveur
	sed -i -e "s/var/www/html/"$dest_site"/g" 000-default.conf #remplace /var/www/html/ par $dest_site
	sed -i -e "s/mailaddress/"$mailaddress"/g" www."$nom_serveur".conf
	sed -i -e "s/mailaddress/"$mailaddress"/g" "$nom_serveur".conf
	sed -i -e "s/servername/"$nom_serveur"/g" www."$nom_serveur".conf
	sed -i -e "s/servername/"$nom_serveur"/g" "$nom_serveur".conf
a2dissite 000-default
a2ensite "$nom_serveur".conf www."$nom_serveur".conf
`$cmdsys restart apache2`
`$cmdsys reload apache2`
##Fin configuration D'Apache2##
