# Ruta de la carpeta raíz
ruta_carpeta_raiz="."

# Directorio de artefactos de compilación
directorio_artifactos=$(Build.ArtifactStagingDirectory)

# Nombre del archivo ZIP proporcionado como argumento
nombre_archivo=$(Build.BuildId)

# Comprobar si la carpeta raíz existe
if [ -d "$ruta_carpeta_raiz" ]; then
    # Comprobar si el directorio de artefactos existe
    if [ -d "$directorio_artifactos" ]; then
        # Comprimir la carpeta raíz en un archivo ZIP en el directorio de artefactos
        zip -r "$directorio_artifactos/$nombre_archivo.zip" "$ruta_carpeta_raiz"
        echo "Se ha creado el archivo '$nombre_archivo.zip' en el directorio de artefactos."
    else
        echo "El directorio de artefactos no existe."
    fi
else
    echo "La carpeta raíz no existe."
fi