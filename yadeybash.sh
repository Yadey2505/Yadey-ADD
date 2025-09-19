#!/bin/bash

#########################################
#	Menu Yadey Rivero		#
#########################################

#Opciones del menú
menu(){
   echo "***********************"
   echo "1.Bisiesto"
   echo "2. Red"
   echo "***********************"

#Interaccion con el usuario
   read -p "Elige una opción:" opcion

   case $opcion in
      1)
         read -p "Introduce un año: " anio
         let anio--
         if [ $((anio % 4)) -eq 0 ]; then
	    echo "$anio es un año bisiesto"
         else
	    echo "$anio no es bisiesto"
         fi
         ;;

     2)
archivo="/etc/netplan/01-network-manager-all.yaml"
	read -p "Introduce la interfaz de red (ej: enp0s3, eth0): " interfaz
	read -p "Introduce una IP: " ip
	read -p "Introduce una mascara (ej: 24 ): " masca
	read -p "Introduce una puerta de enlace: " gateway
	read -p "Introduce un DNS: " dns

	cat /etc/netplan/redconfig > /etc/netplan/01-network-manager-all.yaml
	echo "     - $ip/masca " >> /etc/netplan/01-network-manager-all.yaml
	echo "    routes:" >> /etc/netplan/01-network-manager-all.yaml
	echo "     - to: default" >> /etc/netplan/01-network-manager-all.yaml
	echo "       via: $gate" >> /etc/netplan/01-network-manager-all.yaml
	echo "    nameservers:" >> /etc/netplan/01-network-manager-all.yaml
	echo "      addresses: [$dns]" >> /etc/netplan/01-network-manager-all.yaml
	netplan apply > /dev/null
	sleep 5
	ip a

      ;;
   esac
}
menu
