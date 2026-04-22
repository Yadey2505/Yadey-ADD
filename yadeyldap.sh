#!/bin/bash

admin="cn=admin,dc=yadey2025,dc=ldap"
base="dc=yadey2025,dc=ldap"

echo "----------"
echo "1. Eliminar correo"
echo "2. Modificar correo"
echo "3. Buscar usuarios"
echo "0. Salir"
echo "----------"
read -p "Opcion: " opcion

case $opcion in
    1)
        read -p "UID del usuario: " uid
        read -p "OU (Alumnado/Profesorado): " ou
        echo "dn: uid=$uid,ou=$ou,dc=yadey2025,dc=ldap" > cambio.ldif
        echo "changetype: modify" >> cambio.ldif
        echo "delete: mail" >> cambio.ldif
        ldapmodify -x -D "$admin" -W -f cambio.ldif
        ;;
    2)
        read -p "UID del usuario: " uid
        read -p "OU (Alumnado/Profesorado): " ou
        read -p "Nuevo correo: " correo
        echo "dn: uid=$uid,ou=$ou,dc=yadey2025,dc=ldap" > cambio.ldif
        echo "changetype: modify" >> cambio.ldif
        echo "replace: mail" >> cambio.ldif
        echo "mail: $correo" >> cambio.ldif
        ldapmodify -x -D "$admin" -W -f cambio.ldif
        ;;
    3)
        echo "----------"
        echo "1. Buscar un usuario"
        echo "2. Listar todos"
        read -p "Opcion: " sub
        echo "----------"
        case $sub in
            1)
                read -p "UID: " uid
                ldapsearch -x -LLL -b "$base" "(uid=$uid)" uid mail
                echo "-------------------------------"
                ;;
            2)
                ldapsearch -x -LLL -b "$base" "(objectClass=inetOrgPerson)" uid mail \n | grep -E "^uid:|^mail:|^$"
                echo "-------------------------------"
                ;;
        esac
        ;;
    0)
        exit 0
        ;;
esac
