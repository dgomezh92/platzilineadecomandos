#!/bin/bash

# URL del objetivo
TARGET_URL="URL-Evaluacion"

# Directorio de salida para SQLmap
SQLMAP_DIR="sqlmap"

# Descargar SQLmap si no está presente
if [ ! -d "$SQLMAP_DIR" ]; then
    echo "Descargando SQLmap..."
    git clone --depth=1 https://github.com/sqlmapproject/sqlmap.git "$SQLMAP_DIR"
    echo "SQLmap descargado."
fi

# Ejecutar SQLmap y mostrar resultados en consola
echo "Iniciando prueba con SQLmap en $TARGET_URL..."
python "$SQLMAP_DIR/sqlmap.py" -u "$TARGET_URL" --batch

if echo "$OUTPUT" | grep -q "able to fingerprint the back-end database management system"; then
    echo "Error: Se encontró riesgo de inyección SQL."
else
    echo "No se encontró riesgo de inyección SQL."
fi

