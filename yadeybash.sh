#!/bin/bash

echo "#########################################"
echo "#	    Menu Yadey Rivero           #"
echo "#########################################"
echo ""
#Opciones del menú
menu(){
   echo "***********************"
   echo "1.Bisiesto"
   echo "2. Red"
   echo "3."
   echo "4."
   echo "5."
   echo "6."
   echo "7."
   echo "8."
   echo "9."
   echo "10."
   echo "11."
   echo "12."
   echo "13."
   echo "14."
   echo "15."
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
	 read -p "Introduce una IP: " ip
	 read -p "Introduce una mascara (ej: 24 ): " masca
	 read -p "Introduce una puerta de enlace: " gateway
	 read -p "Introduce un DNS: " dns

         echo "      - $ip/$masca" >> /etc/netplan/01-network-manager-all.yaml
         echo "    routes:" >> /etc/netplan/01-network-manager-all.yaml
         echo "      - to: default" >> /etc/netplan/01-network-manager-all.yaml
         echo "        via: $gateway" >> /etc/netplan/01-network-manager-all.yaml
         echo "    nameservers:" >> /etc/netplan/01-network-manager-all.yaml
         echo "      addresses: [$dns]" >> /etc/netplan/01-network-manager-all.yaml
	 netplan apply > /dev/null
	 sleep 5
	 ip a

       ;;

    esac
}
menu
