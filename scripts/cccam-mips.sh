#!/bin/bash
# Provides: ChristopherE2
# Description: Script para instalación de CCcam.Mips
# Version: 2.0
# Date: 27/09/2022

URL_CCCAM="https://github.com/ChristopherE2/CCcam/archive/refs/heads/main.zip"

ping -c 1 github.com
if [ $? -ne 1 ];
then
	echo "¡Conexión a internet OK!"
	## CCcam download ##
	cd /tmp
	wget $URL_CCCAM
	unzip main.zip
	## Bin Install ##
	mv /tmp/CCcam-main/Mipsel/CCcam.Mips /usr/bin
	chmod 755 /usr/bin/CCcam.Mips
	## Script Install ##
	mv /tmp/CCcam-main/Mipsel/softcam.CCcam.Mips /etc/init.d
	chmod 755 /etc/init.d/softcam.CCcam.Mips
	## Config Install ##
	mv /tmp/CCcam-main/Config/* /etc
	## Lib Install ##
	mv /tmp/CCcam-main/Mipsel/libgcc_s.so.1 /lib
	echo "¡Se ha instalado CCcam.Mips con éxito!"
	echo "Reiniciando decodificador en 5 ..."
	sleep 1s
	echo "                             4 ..."
	sleep 1s
	echo "                             3 ..."
	sleep 1s
	echo "                             2 ..."
	sleep 1s
	echo "                             1 ..."
	sleep 1s
	wget -O /dev/null -q http://127.0.0.1/web/powerstate?newstate=2
else
	echo "¡Conexión a internet NOK!"
fi