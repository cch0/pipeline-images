FROM ubuntu:22.04

# Set non-interactive frontend to avoid prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# Define build arguments for tool versions
ARG AWSCLI_VERSION=2.15.57
ARG ORAS_VERSION=1.2.0
ARG YQ_VERSION=4.44.3

# Update package lists and install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    lsb-release \
    tar \
    gzip \
    jq \
    unzip \
    build-essential \
    pkg-config \
    libssl-dev \
    podman \
    wget \
    zip \
    net-tools \
    openssh-client \
    && rm -rf /var/lib/apt/lists/*

# Install yq with specified version
RUN curl -L "https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/yq_linux_$(dpkg --print-architecture)" -o /usr/local/bin/yq \
    && chmod +x /usr/local/bin/yq

# Add Docker's official GPG key
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Set up Docker repository
RUN echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
RUN apt-get update && apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    && rm -rf /var/lib/apt/lists/*

# Install Docker Compose
RUN curl -L "https://github.com/docker/compose/releases/download/v2.24.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-$(uname -m)-${AWSCLI_VERSION}.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf awscliv2.zip aws

# Install ORAS
RUN curl -L "https://github.com/oras-project/oras/releases/download/v${ORAS_VERSION}/oras_${ORAS_VERSION}_linux_$(dpkg --print-architecture).tar.gz" -o oras.tar.gz \
    && tar -xzf oras.tar.gz -C /usr/local/bin \
    && rm oras.tar.gz

# Install git-lfs
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash \
    && apt-get update && apt-get install -y git-lfs \
    && rm -rf /var/lib/apt/lists/*

# Verify installations
RUN docker --version && \
    docker-compose --version && \
    podman --version && \
    aws --version && \
    oras version && \
    yq --version && \
    jq --version && \
    tar --version && \
    gzip --version && \
    git-lfs --version && \
    netstat --version && \
    ssh -V && \
    wget --version && \
    zip --version
