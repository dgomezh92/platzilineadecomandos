#!/bin/bash

# Salir del login actual de Docker
docker logout https://index.docker.io/v1/

# Variables de entorno (Asegúrate de que estas variables estén definidas adecuadamente)
# Variables de entorno
AWS_ACCESS_KEY_ID="Remplazar"
AWS_SECRET_ACCESS_KEY="Remplazar"
AWS_REGION="Remplazar"
DOCKER_IMAGE_NAME="Remplazar"
ECR_REGISTRY_URL="Remplazar"
BUILD_NUMBER="remplazar"

# Configurar AWS CLI
aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID"
aws configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY"
aws configure set default.region "$AWS_REGION"

# Obtener el número de compilación y limpiarlo (reemplaza esto por tu lógica real)
BUILD_NUMBER_CLEANED=$(echo "$BUILD_NUMBER" | tr -d ' ' | sed 's/[^A-Za-z0-9._-]//g')

# Iniciar sesión en ECR
aws ecr get-login-password --region "$AWS_REGION" | docker login --username AWS --password-stdin "$ECR_REGISTRY_URL"

# Construir la imagen de Docker (asegúrate de que estás en el directorio correcto)
docker buildx build . -t "$DOCKER_IMAGE_NAME:$BUILD_NUMBER_CLEANED"

# Etiquetar la imagen
docker tag "$DOCKER_IMAGE_NAME:$BUILD_NUMBER_CLEANED" "$ECR_REGISTRY_URL/$DOCKER_IMAGE_NAME:$BUILD_NUMBER_CLEANED"

# Subir la imagen a ECR
docker push "$ECR_REGISTRY_URL/$DOCKER_IMAGE_NAME:$BUILD_NUMBER_CLEANED"

# Cerrar sesión en ECR
docker logout "$ECR_REGISTRY_URL"

