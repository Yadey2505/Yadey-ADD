#!/bin/bash

# Script para filtrar errores en /var/log en manjaro

OUTPUT="errores_filtrados_manjaro.log"

# Vaciar archivo de salida
> "$OUTPUT"

# Recorrer archivos de /var/log
for archivo in /var/log/*; do

    if [ -f "$archivo" ]; then
        
        # Filtrar lineas con error o fail
        ERRORES=$(grep -iE "error|fail" "$archivo")

        if [ -n "$ERRORES" ]; then
            echo "Archivo: $archivo" >> "$OUTPUT"
            echo "$ERRORES" >> "$OUTPUT"
            echo "" >> "$OUTPUT"
        fi
    fi
done

echo "Completado. Archivo generado: $OUTPUT"
