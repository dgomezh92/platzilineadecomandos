#!/bin/bash

# Directorio en el que deseas eliminar los directorios __pycache__
directorio="."

# Buscar y eliminar los directorios __pycache__
find "${directorio}" -type d -name "__pycache__" -exec rm -rf {} +

echo "Los directorios __pycache__ han sido eliminados."
