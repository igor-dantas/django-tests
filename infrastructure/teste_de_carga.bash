#!/bin/bash

# Função para imprimir mensagens de erro e sair
function error_exit {
    echo "$1" 1>&2
    exit 1
}

# Perguntar o nome do repositório ECR
read -p "Enter the ECR repository name (e.g., myrepo/django-test): " REPO_NAME
if [ -z "$REPO_NAME" ]; then
    error_exit "Repository name cannot be empty. Exiting."
fi

# Definir a tag da imagem
IMAGE_TAG="latest"
IMAGE_NAME="$REPO_NAME:$IMAGE_TAG"

# Fazer login no ECR
echo "Logging into Amazon ECR..."
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $REPO_NAME

if [ $? -ne 0 ]; then
    error_exit "ECR login failed. Exiting."
fi

echo "ECR login successful."

# Construir a imagem do Docker
echo "Building Docker image..."
docker build -t $IMAGE_NAME ../.

if [ $? -ne 0 ]; then
    error_exit "Docker build failed. Exiting."
fi

echo "Docker build completed successfully."

# Fazer o push da imagem para o ECR
echo "Pushing Docker image to ECR..."
docker push $IMAGE_NAME

if [ $? -ne 0 ]; then
    error_exit "Docker push failed. Exiting."
fi

echo "Docker push completed successfully."

# Executar o terraform plan
echo "Running terraform plan..."
terraform plan -out=tfplan

if [ $? -ne 0 ]; then
    error_exit "Terraform plan failed. Exiting."
fi

# Perguntar ao usuário se deseja aplicar o plano
read -p "Do you want to apply this plan? (yes/no) " choice

if [ "$choice" == "yes" ]; then
    # Aplicar o plano com terraform apply
    echo "Applying terraform plan..."
    terraform apply --auto-approve tfplan

    if [ $? -ne 0 ]; then
        error_exit "Terraform apply failed. Exiting."
    fi

    echo "Terraform apply completed successfully."
else
    echo "Terraform apply aborted."
fi

# Remover o arquivo de plano
rm -f tfplan
