#!/bin/bash

echo "Quel est le nom du serveur? (ex: hgfr.eu)"
read nom_serveur

#Variable
vhost='/etc/apache2/sites-available/'
rep_web='/var/www/'
apache='service apache2'

##<installation paquet>
apt-get update
apt-get upgrade
apt-get install apache2 mysql-server php7 php7-mysql phpmyadmin
echo -e "Installation d'apache 2, mysql server, proftpd, php5 et ses modules, phpmyadmin \t\t\t\t\t\t\t [\033[032mOK\033[030m]"
##</installation paquet>

##<apache>
a2enmod ssl
	#<virtualhost>
		cd $vhost
		cp default default.save
		sed -i -e "s/localhost/$nom_serveur/g" default #remplace le mot "localhost" par $nom_serveur
		wget http://hgfr.eu/autre/example.hgfr.eu -o example.$nom_serveur
		cp example.$nom_serveur www.$nom_serveur
		cp example.$nom_serveur $serveur
		sed -i -e "s/change/$nom_serveur/g" www.$nom_serveur
		sed -i -e "s/change/$nom_serveur/g" $nom_serveur
	#</virtualhost>
$apache reload
$apache restart
##</apache>
