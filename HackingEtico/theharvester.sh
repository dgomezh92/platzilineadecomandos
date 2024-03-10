#!/bin/bash
# Actualizar repositorios e instalar theHarvester
sudo apt update 2>/dev/null
sudo apt install theharvester -y 2>/dev/null

# Carga las variables
URL_SCAN="c3ydhkr48j.us-east-1.awsapprunner.com"

# Ejecutar theHarvester y redirigir la salida estándar hacia la consola
theHarvester 2>&1

# Ejecutar una prueba buscando información sobre el dominio example.com
theHarvester -d $URL_SCAN -b all

echo "Proceso completado."

docker pull kalilinux/kali-last-release


docker run  -it --network=host kalilinux/kali-last-release bash


theHarvester -d c3ydhkr48j.us-east-1.awsapprunner.com -b all