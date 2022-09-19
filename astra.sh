#!/bin/bash
# Provides: ChristopherE2
# Description: Script para actualizaciones de lista de canales astra
# Version: 4.0
# Date: 19/09/2022

URL_BOUQUET="https://github.com/ChristopherE2/astra/raw/main/astra.tar.gz"

ping -c 1 github.com
if [ $? -ne 1 ];
then
	echo "¡Conexión a internet OK!"
	## Lamedb + Bouquet + Satellites Download ##
	cd /tmp/
	wget $URL_BOUQUET
	chmod 755 /tmp/astra.tar.gz
	tar -xzvf astra.tar.gz
	## Satellites Remove ##
	rm -rf /etc/tuxbox/satellites.xml
	## Satellites Install ##
	mv /tmp/tuxbox/satellites.xml /etc/tuxbox/
	## Bouquet Remove ##
	cd /etc/enigma2 && rm -rf *.tv *.radio blacklist lamedb
	## Bouquet Install ##
	mv /tmp/enigma2/* /etc/enigma2
	## Trash Remove ##
	rm -rf /tmp/tuxbox /tmp/enigma2 /tmp/astra.tar.gz /etc/enigma2/*.del
	## Lamedb & Bouquet Reload ##
	wget -qO - http://127.0.0.1/web/servicelistreload?mode=0
	echo "¡Canales astra actualizados con éxito!"
	sleep 5s
	wget -O /dev/null -q http://127.0.0.1/web/powerstate?newstate=3
else
	echo "¡Conexión a internet NOK!"
fi
