#!/bin/bash

# Verificar si Nmap está instalado
if ! command -v nmap &> /dev/null
then
    echo "Nmap no está instalado. Instalando..."
    # Instalar Nmap utilizando el gestor de paquetes de tu sistema (apt, yum, etc.)
    # Puedes cambiar 'apt' por el gestor de paquetes de tu sistema si no estás en un sistema basado en Debian/Ubuntu
    sudo apt update && sudo apt install -y nmap
fi

# Ejecutar Nmap
echo "Ejecutando Nmap..."
# Aquí puedes agregar tus opciones de Nmap según tus necesidades
nmap c3ydhkr48j.us-east-1.awsapprunner.com
# O escanear un host específico: nmap example.com
nmap --version