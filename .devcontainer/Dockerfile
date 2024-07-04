# Use a imagem base padrão do Codespaces com Node.js
FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu-22.04

# Instale dependências básicas
RUN apt-get update && \
    apt-get install -y curl apt-transport-https ca-certificates gnupg lsb-release

# Instale Docker
RUN curl -fsSL https://get.docker.com -o get-docker.sh && \
    sh get-docker.sh && \
    usermod -aG docker vscode

# Instale Kind
RUN curl -Lo /usr/local/bin/kind https://kind.sigs.k8s.io/dl/v0.19.0/kind-linux-amd64 && \
    chmod +x /usr/local/bin/kind

# Instale kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/

# Permitir que o Docker seja executado sem sudo
RUN echo 'vscode ALL=(ALL) NOPASSWD: /usr/bin/dockerd' >> /etc/sudoers.d/nopasswd
