#!/bin/bash

# Функция установки acme.sh
install_acme_sh() {
    echo "Installing acme.sh..."
    if [ -d "$HOME/.acme.sh" ]; then
        echo "acme.sh is already installed. Skipping installation."
    else
        curl https://get.acme.sh | sh -s email="$EMAIL"
    fi
}

# Выдача сертификатов для домена
issue_certificate() {
    echo -e "e[32m[INFO]e[0m Issuing wildcard certificate for $DOMAIN"
    ~/.acme.sh/acme.sh --set-default-ca --server letsencrypt --issue --standalone -d "$DOMAIN"
    -d "*.$DOMAIN"
    --key-file ~/services/certs/key.pem
    --fullchain-file ~/services/certs/fullchain.pem

    echo "Certificates saved in ~/services/certs/"
}

install_acme_sh
issue_certificate
