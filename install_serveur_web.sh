#################################################
# Script automatisation déploiement serveur web #
#################################################

#!/bin/bash

echo "Quel est le nom du serveur? (ex: hgfr.eu)"
read nom_serveur
echo "Quel sera la destination des site? (default = /var/www/html/)"
read dest_site

#Variable
vhost='/etc/apache2/sites-available/'
cmdsys='systemctl'

##<installation paquet>
apt update
apt upgrade
apt install apache2 mariadb-server php7.0 php7.0-mysql phpmyadmin
echo -e "Installation d'apache 2, mysql server, php7 et ses modules, phpmyadmin \t\t\t\t\t\t\t [\033[032mOK\033[030m]"
##</installation paquet>

##<apache>
#Activation des services
a2enmod ssl
	cd $vhost
	cp default default.save
	sed -i -e "s/localhost/$nom_serveur/g" default #remplace le mot "localhost" par $nom_serveur
	sed -i -e "s/var/www/$dest_site/g" defaut #remplace /var/www/html/ par $dest_site
	cp example.gthery.ovh $nom_serveur
	cp example.$nom_serveur www.$nom_serveur
	sed -i -e "s/change/$nom_serveur/g" www.$nom_serveur
	sed -i -e "s/change/$nom_serveur/g" $nom_serveur
	sed -i -e "s/change2/$dest_site/g" www.$nom_serveur
	sed -i -e "s/change2/$dest_site/g" $nom_serveur
a2dissite default
a2ensite "$nom_serveur" "www.$nom_serveur"
$cmdsys reload apache2
$cmdsys restart apache2
##</apache>
