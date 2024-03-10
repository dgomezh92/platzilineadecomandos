
# Cuenta de destino
AWS_ACCESS_KEY_DESTINO="$(valor_aws_access_key_destino)"
AWS_SECRET_KEY_DESTINO="$(valor_aws_secret_key_destino)"
AWS_REGION_DESTINO="$(region_destino)"
REPOSITORIO_DESTINO="$(nombre_repositorio_destino)"
AWS_ACCOUNT_ID_DESTINO="$(id_cuenta_destino)"
# Configura las siguientes variables según tu entorno
SERVICE_ARN="$(SERVICE_ARN)"
IMAGE_URI="$AWS_ACCOUNT_ID_DESTINO.dkr.ecr.$AWS_REGION_DESTINO.amazonaws.com/$REPOSITORIO_DESTINO:$(Build.BuildNumber)"

# Opcional: Configura AWS CLI profile si no estás utilizando el default
# AWS_PROFILE="--profile tu-perfil"


# Despliega la nueva imagen al servicio de App Runner
aws apprunner update-service --service-arn $SERVICE_ARN \
    --source-configuration "{\"ImageRepository\": {\"ImageIdentifier\": \"$IMAGE_URI\", \"ImageConfiguration\": { \"Port\": \"8080\" }, \"ImageRepositoryType\": \"ECR\"}}" $AWS_PROFILE
