#!/bin/bash

# Saia se um comando falhar
set -e

# Verifique se o Kind está instalado
if ! command -v kind &> /dev/null
then
    echo "Kind não encontrado. Instalando Kind..."
    # Instale o Kind
    curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.18.0/kind-linux-amd64
    chmod +x ./kind
    sudo mv ./kind /usr/local/bin/kind
else
    echo "Kind já está instalado."
fi

# Verifique se o kubectl está instalado
if ! command -v kubectl &> /dev/null
then
    echo "kubectl não encontrado. Instalando kubectl..."
    # Instale o kubectl
    curl -LO "https://dl.k8s.io/release/v1.27.1/bin/linux/amd64/kubectl"
    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl
else
    echo "kubectl já está instalado."
fi

# Crie um novo cluster Kind
echo "Criando o cluster Kind..."
kind create cluster --name my-cluster --config <(cat <<EOF
# Configuração do Kind
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
networking:
  disableDefaultCNI: false
  ipFamily: ipv4
EOF
)

# Verifique o status do cluster
echo "Verificando o status do cluster Kind..."
kind get clusters

# Configura o kubectl para usar o novo cluster
echo "Configurando kubectl para usar o cluster Kind..."
kubectl cluster-info --context kind-my-cluster

echo "O Kind foi instalado e o cluster foi criado com sucesso!"
