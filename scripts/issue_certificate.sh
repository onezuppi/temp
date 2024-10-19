#!/bin/bash

# Функция установки acme.sh
install_acme_sh() {
    echo "Installing acme.sh..."
    if [ -d "$HOME/.acme.sh" ]; then
        echo "acme.sh is already installed. Skipping installation."
    else
        curl https://get.acme.sh | sh -s email=$EMAIL
    fi
}

# Выдача сертификатов для домена
issue_certificate() {
    echo -e "\e[32m[INFO]\e[0m Issuing wildcard certificate for $DOMAIN"
    
    # Ensure directory for certs exists
    mkdir -p certs

    # Issue the certificate
    ~/.acme.sh/acme.sh --set-default-ca --server letsencrypt \
    --issue --standalone -d "$DOMAIN" -d "$PANEL_SUBDOMAIN.$DOMAIN" -d "$SUB_SUBDOMAIN.$DOMAIN" \
    --key-file certs/key.pem --fullchain-file certs/fullchain.pem

    echo "Certificates saved in certs"
}


# Загрузка переменных из .env
if [ -f .env ]; then
  export $(cat .env | grep -v '#' | awk '/=/ {print $1}')
else
  echo ".env file not found!"
  exit 1
fi

install_acme_sh
issue_certificate
