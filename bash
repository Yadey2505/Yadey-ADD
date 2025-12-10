#!/bin/bash

# --------------------
# 1. bisiesto
# --------------------
yadey_bisiesto() {
  anio="$1"
  if [ -z "$anio" ]; then
    echo "Debes indicar un año."
    return
  fi

  if [ $((anio % 400)) -eq 0 ]; then
    echo "Es bisiesto"
  elif [ $((anio % 100)) -eq 0 ]; then
    echo "No es bisiesto"
  elif [ $((anio % 4)) -eq 0 ]; then
    echo "Es bisiesto"
  else
    echo "No es bisiesto"
  fi
}

# --------------------
# 2. configurarred (VERSIÓN SIMPLE)
# --------------------
yadey_configurarred() {
  ip="$1"
  mascara="$2"
  puerta="$3"
  dns="$4"

  if [ -z "$ip" ] || [ -z "$mascara" ] || [ -z "$puerta" ] || [ -z "$dns" ]; then
    echo "Faltan datos."
    return
  fi

  echo "Introduce el nombre de la interfaz (ej: eth0):"
  read interfaz

  if [ -z "$interfaz" ]; then
    echo "No se indicó interfaz."
    return
  fi

  # Quitar configuraciones viejas
  ip addr flush dev "$interfaz"

  # Aplicar IP
  ip addr add "$ip/$mascara" dev "$interfaz"
  ip link set "$interfaz" up

  # Puerta de enlace
  ip route add default via "$puerta"

  # DNS
  echo "nameserver $dns" > /etc/resolv.conf

  echo "Configuración aplicada."
}

# --------------------
# 3. adivina
# --------------------
yadey_adivina() {
  numero=$((RANDOM % 100 + 1))
  intentos=1

  while [ $intentos -le 5 ]; do
    echo "Intento $intentos de 5:"
    read intento

    if [ "$intento" -eq "$numero" ]; then
      echo "¡Correcto!"
      return
    elif [ "$intento" -lt "$numero" ]; then
      echo "El número es mayor"
    else
      echo "El número es menor"
    fi

    intentos=$((intentos + 1))
  done

  echo "No acertaste. El número era $numero"
}

# --------------------
# 4. buscar
# --------------------
yadey_buscar() {
  fichero="$1"
  if [ -z "$fichero" ]; then
    echo "Debes indicar un fichero."
    return
  fi

  ruta=$(find / -type f -name "$fichero" 2>/dev/null | head -n 1)

  if [ -z "$ruta" ]; then
    echo "No existe."
    return
  fi

  echo "Encontrado en: $ruta"
  vocales=$(tr -cd "aeiouAEIOU" < "$ruta" | wc -c)
  echo "Vocales: $vocales"
}

# --------------------
# 5. contar
# --------------------
yadey_contar() {
  dir="$1"
  if [ ! -d "$dir" ]; then
    echo "No es un directorio."
    return
  fi

  num=$(ls -1 "$dir" 2>/dev/null | wc -l)
  echo "Hay $num ficheros."
}

# --------------------
# 6. permisosoctal
# --------------------
yadey_permisosoctal() {
  ruta="$1"
  if [ ! -e "$ruta" ]; then
    echo "No existe."
    return
  fi

  stat -c "%a" "$ruta"
}

# --------------------
# 7. romano (simple)
# --------------------
yadey_romano() {
  num=$1
  if [ -z "$num" ]; then echo "Falta número"; return; fi
  if [ "$num" -lt 1 ] || [ "$num" -gt 200 ]; then echo "Fuera de rango"; return; fi

  romano=""

  while [ $num -ge 100 ]; do romano="${romano}C"; num=$((num-100)); done
  if [ $num -ge 90 ]; then romano="${romano}XC"; num=$((num-90)); fi
  if [ $num -ge 50 ]; then romano="${romano}L"; num=$((num-50)); fi
  if [ $num -ge 40 ]; then romano="${romano}XL"; num=$((num-40)); fi
  while [ $num -ge 10 ]; do romano="${romano}X"; num=$((num-10)); done
  if [ $num -ge 9 ]; then romano="${romano}IX"; num=$((num-9)); fi
  if [ $num -ge 5 ]; then romano="${romano}V"; num=$((num-5)); fi
  if [ $num -ge 4 ]; then romano="${romano}IV"; num=$((num-4)); fi
  while [ $num -ge 1 ]; do romano="${romano}I"; num=$((num-1)); done

  echo "$romano"
}

# --------------------
# 8. automatizar
# --------------------
yadey_automatizar() {
  base="/mnt/usuarios"

  if [ ! -d "$base" ]; then
    echo "No existe /mnt/usuarios."
    return
  fi

  if [ -z "$(ls -A $base)" ]; then
    echo "Vacío."
    return
  fi

  for f in "$base"/*; do
    usuario=$(basename "$f")
    useradd -m "$usuario"
    while read carpeta; do
      mkdir -p "/home/$usuario/$carpeta"
    done < "$f"
    rm "$f"
  done
}

# --------------------
# 9. crear
# --------------------
yadey_crear() {
  nombre="$1"
  tam="$2"

  if [ -z "$nombre" ]; then nombre="yadey_vacio"; fi
  if [ -z "$tam" ]; then tam=1024; fi

  dd if=/dev/zero of="$nombre" bs=1024 count="$tam" 2>/dev/null
  echo "Creado $nombre"
}

# --------------------
# 10. crear_2
# --------------------
yadey_crear2() {
  base="$1"
  tam="$2"

  if [ -z "$base" ]; then base="yadey_vacio"; fi
  if [ -z "$tam" ]; then tam=1024; fi

  nombre="$base"

  if [ -e "$nombre" ]; then
    i=1
    while [ $i -le 9 ]; do
      if [ ! -e "${base}${i}" ]; then
        nombre="${base}${i}"
        break
      fi
      i=$((i+1))
    done

    if [ $i -gt 9 ]; then
      echo "No se puede crear."
      return
    fi
  fi

  dd if=/dev/zero of="$nombre" bs=1024 count="$tam" 2>/dev/null
  echo "Creado $nombre"
}

# --------------------
# 11. reescribir
# --------------------
yadey_reescribir() {
  echo "$1" | tr "aeiouAEIOU" "1234512345"
}

# --------------------
# 12. contusu
# --------------------
yadey_contusu() {
  echo "Usuarios:"
  ls /home
}

# --------------------
# 13. quita_blancos
# --------------------
yadey_quita_blancos() {
  for f in *" "*; do
    nuevo=$(echo "$f" | tr " " "_")
    mv "$f" "$nuevo"
  done
}

# --------------------
# 14. lineas
# --------------------
yadey_lineas() {
  c="$1"
  l="$2"
  n="$3"

  i=1
  while [ $i -le $n ]; do
    linea=""
    j=1
    while [ $j -le $l ]; do
      linea="${linea}${c}"
      j=$((j+1))
    done
    echo "$linea"
    i=$((i+1))
  done
}

# --------------------
# 15. analizar
# --------------------
yadey_analizar() {
  dir="$1"
  shift

  for ext in "$@"; do
    num=$(find "$dir" -name "*.$ext" | wc -l)
    echo "$ext : $num"
  done
}
