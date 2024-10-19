#!/bin/bash
set -e

# Функция установки пакета
install_package() {
    PACKAGE=$1
    echo "Installing $PACKAGE"
    apt-get -y install "$PACKAGE"
}

# Установка Docker и Docker Compose на Ubuntu
install_docker_and_compose() {
    echo "Docker not found. Installing Docker and Docker Compose..."

    sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io

    sudo systemctl enable docker
    sudo systemctl start docker

    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

    echo "Docker and Docker Compose installed successfully."
}

# Проверка наличия Docker и установка, если не установлен
if ! command -v docker >/dev/null 2>&1; then
    install_docker_and_compose
fi


# Проверка зависимостей
check_dependencies() {
    sudo apt update -y
    sudo apt upgrade -y

    if ! command -v idn >/dev/null 2>&1; then
        echo "idn not found. Installing..."
        install_package idn
    fi
    if ! command -v socat >/dev/null 2>&1; then
        echo "socat not found. Installing..."
        install_package socat
    fi
    if ! command -v git >/dev/null 2>&1; then
        echo "git not found. Installing..."
        install_package git
    fi
    if ! command -v jq >/dev/null 2>&1; then
        echo "jq not found. Installing..."
        install_package jq
    fi
    if ! command -v curl >/dev/null 2>&1; then
        echo "curl not found. Installing..."
        install_package curl
    fi
    if ! command -v docker >/dev/null 2>&1; then
        install_docker_and_compose
    fi
    if ! command -v unzip >/dev/null 2>&1; then
        echo "unzip not found. Installing..."
        install_package unzip
    fi
    if ! command -v wget >/dev/null 2>&1; then
        echo "wget not found. Installing..."
        install_package wget
    fi
}

check_dependencies
