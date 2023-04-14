COMMIT_HASH=$(git rev-parse --short HEAD)
REPOSITORY=haissamfawaz
APP_NAME=neuraubackend
IMAGE_ADDRESS="$REPOSITORY/$APP_NAME:$COMMIT_HASH"
docker build ../ -t $IMAGE_ADDRESS
docker push $IMAGE_ADDRESS

cd infrastructure
sed -i "s~.image:.*~ image: $IMAGE_ADDRESS~" manifest/deployment.yaml
terraform apply -var-file="vars/main.tfvars" --auto-approve