#!/bin/bash

# Directorio que quieres limpiar
directorio="."

# Carpeta que deseas conservar
carpeta_a_conservar="nombre_carpeta_conservar"

# Mover contenido de src a la carpeta raíz
mv "${directorio}/${carpeta_a_conservar}/"* "${directorio}/"

# Eliminar carpeta src si está vacía
if [ -z "$(ls -A "${directorio}/${carpeta_a_conservar}/")" ]; then
    rm -r "${directorio}/${carpeta_a_conservar}/"
    echo "La carpeta ${carpeta_a_conservar} ha sido eliminada."
fi
