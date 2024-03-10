#!/bin/bash
# Directorio que quieres limpiar
directorio="."
# Carpeta que deseas conservar
carpeta_a_conservar="src"
# Crear una lista de todos los archivos y directorios dentro del directorio excepto la carpeta a conservar
archivos_a_eliminar=$(find "${directorio}" -mindepth 1 -maxdepth 1 ! -name "${carpeta_a_conservar}" -exec echo {} \;)
# Eliminar los archivos y directorios
if [ -n "$archivos_a_eliminar" ]; then
    echo "Eliminando archivos y directorios:"
    echo "$archivos_a_eliminar"
    rm -rf $archivos_a_eliminar
else
    echo "No se encontraron archivos o directorios para eliminar."
fi