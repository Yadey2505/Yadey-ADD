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
   echo "3. Adivina"
   echo "4. Buscar"
   echo "5. Contar"
   echo "6. Permiso Octal"
   echo "7. Romano"
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

	 cat plantillared > /etc/netplan/01-network-manager-all.yaml
         echo "     - $ip/$masca" >> /etc/netplan/01-network-manager-all.yaml
         echo "    routes:" >> /etc/netplan/01-network-manager-all.yaml
         echo "     - to: default" >> /etc/netplan/01-network-manager-all.yaml
         echo "       via: $gateway" >> /etc/netplan/01-network-manager-all.yaml
         echo "    nameservers:" >> /etc/netplan/01-network-manager-all.yaml
         echo "      addresses: [$dns]" >> /etc/netplan/01-network-manager-all.yaml
	 netplan apply > /dev/null
	 sleep 5
	 ip a

       ;;


     3)
	#Generar numeor random
        nume=$((RANDOM % 100 +1))

	intentos=0
	max_inte=5

	echo "Intenta adivinar el numero que he pensado entre 1 y 100"
	echo "Tienes $max_inte intentos para adivinarlo"

	#Bucle para los intentos
	while [ $intentos -lt $max_inte ];
	do

	#Contar los intentos
		let intentos=intentos+1
		read -p "Intento $intentos: Escribe tu numero: " user

		if [ "$user" -eq "$nume" ]; then
	    	  echo "Has adivinado el numero en $intentos intentos"
	    	exit 0
		elif [ "$user" -lt "$nume" ]; then
	    	  echo "El numero es mayor que $user"
		else
	    	  echo "El numero es menor que $user"
		fi
	done

	#Sin intentos
	echo ""
	echo "No tienes mas intentos"
	echo "El numero era: $nume"
    ;;

    4)
	read -p "Introduce el nombre de un fichero: " fichero
	ruta=$(find / -type f -name "$fichero")
	if [ -e $ruta ]; then
            echo "$fichero existe en $ruta"
	else
	    echo "Error el fichero no existe"

	fi
	vocales=$(tr -cd 'aeiouAEIOU' < "$ruta" | wc -c)
		echo "Numero de vocales es = $vocales"

    ;;


    esac
}
menu
