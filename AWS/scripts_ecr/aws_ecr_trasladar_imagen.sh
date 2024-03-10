#----------------------------------------------------------------------------------------------------------
#Listar contenedores 
#docker images
#Eliminar imagenes antiguas sin uso
#docker images | grep '^cerberus' | awk '{print $3}' | xargs docker rmi -f

# Definir las credenciales de ambas cuentas de AWS y detalles de los repositorios
# Cuenta de origen
AWS_ACCESS_KEY_ORIGEN="$(valor_aws_access_key_origen)"
AWS_SECRET_KEY_ORIGEN="$(valor_aws_secret_key_origen)"
AWS_REGION_ORIGEN="$(region_origen)"
REPOSITORIO_ORIGEN="$(nombre_repositorio_origen)"
AWS_ACCOUNT_ID_ORIGEN="$(id_cuenta_origen)"
# Cuenta de destino
AWS_ACCESS_KEY_DESTINO="$(valor_aws_access_key_destino)"
AWS_SECRET_KEY_DESTINO="$(valor_aws_secret_key_destino)"
AWS_REGION_DESTINO="$(region_destino)"
REPOSITORIO_DESTINO="$(nombre_repositorio_destino)"
AWS_ACCOUNT_ID_DESTINO="$(id_cuenta_destino)"
# Autenticarse con la cuenta de origen
aws ecr get-login-password --region $AWS_REGION_ORIGEN | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID_ORIGEN}.dkr.ecr.${AWS_REGION_ORIGEN}.amazonaws.com
# Definir el nombre del repositorio y etiqueta de la imagen
ETIQUETA_IMAGEN="$(Build.BuildNumber)"
# Autenticarse con la cuenta de origen
aws configure set aws_access_key_id $AWS_ACCESS_KEY_ORIGEN
aws configure set aws_secret_access_key $AWS_SECRET_KEY_ORIGEN
aws configure set region $AWS_REGION_ORIGEN
# Verificar si el repositorio de origen existe
aws ecr describe-repositories --repository-names $REPOSITORIO_ORIGEN &>/dev/null
if [ $? -ne 0 ]; then
    echo "Error: El repositorio de origen $REPOSITORIO_ORIGEN no existe."
    exit 1
fi
# Obtener la URL de la imagen desde el repositorio de origen
URL_IMAGEN_ORIGEN=$(aws ecr get-login-password --region $AWS_REGION_ORIGEN | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID_ORIGEN}.dkr.ecr.${AWS_REGION_ORIGEN}.amazonaws.com)
URL_COMPLETA_ORIGEN="${AWS_ACCOUNT_ID_ORIGEN}.dkr.ecr.${AWS_REGION_ORIGEN}.amazonaws.com/${REPOSITORIO_ORIGEN}:${ETIQUETA_IMAGEN}"
docker pull $URL_COMPLETA_ORIGEN
ECR_REGISTRY_URL_ORIGEN="${AWS_ACCOUNT_ID_ORIGEN}.dkr.ecr.${AWS_REGION_ORIGEN}.amazonaws.com"
docker logout $ECR_REGISTRY_URL_ORIGEN

docker tag ${URL_COMPLETA_ORIGEN}  ${AWS_ACCOUNT_ID_DESTINO}.dkr.ecr.${AWS_REGION_DESTINO}.amazonaws.com/${REPOSITORIO_DESTINO}:${ETIQUETA_IMAGEN}
echo "####################################################################################################################################################"
echo "Inicia Carga de  la imagen destino "
echo "####################################################################################################################################################"
echo "####################################################################################################################################################"
docker images
#Autenticarse con la cuenta de destino
aws configure set aws_access_key_id $AWS_ACCESS_KEY_DESTINO
aws configure set aws_secret_access_key $AWS_SECRET_KEY_DESTINO
aws configure set region $AWS_REGION_DESTINO
# Autenticarse con la cuenta de destino

aws ecr get-login-password --region $AWS_REGION_DESTINO | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID_DESTINO}.dkr.ecr.${AWS_REGION_DESTINO}.amazonaws.com

# Validación de la autenticación con la cuenta de destino
aws ecr describe-repositories --region $AWS_REGION_DESTINO
if [ $? -ne 0 ]; then
    echo "Error: La autenticación con el repositorio de destino falló."
    exit 1
fi
# Hacer push de la imagen al repositorio de destino
echo "####################################################################################################################################################"
echo "Termina de descargar la imagen de origen "
echo "####################################################################################################################################################"
docker push ${AWS_ACCOUNT_ID_DESTINO}.dkr.ecr.${AWS_REGION_DESTINO}.amazonaws.com/${REPOSITORIO_DESTINO}:${ETIQUETA_IMAGEN}
echo "La imagen ha sido transferida con éxito al repositorio de destino."

