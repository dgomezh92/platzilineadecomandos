#!/bin/bash

# Cambiar al directorio raíz si es necesario

found_files=false

# Función para buscar archivos y directorios
search_files() {
    if find . -type d -name "$1" -print -quit | grep -q '.'; then
        echo "Se encontró el directorio $1 que debería estar en .gitignore."
        found_files=true
    fi

    if find . -type f -name "$1" -print -quit | grep -q '.'; then
        echo "Se encontró el archivo $1 que debería estar en .gitignore."
        found_files=true
    fi
}

# Lista de archivos y directorios para buscar
search_files "bin"
search_files "obj"
search_files "*.user"
search_files "*.suo"
search_files ".vs"

if [ "$found_files" = true ]; then
    echo "Error: Se encontraron archivos o directorios que deberían estar en .gitignore."
    exit 1
else
    echo "No se encontraron archivos o directorios que deban estar en .gitignore."
fi
