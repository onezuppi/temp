#!/bin/bash

# Загрузка переменных из .env
if [ -f .env ]; then
  export $(cat .env | grep -v '#' | awk '/=/ {print $1}')
else
  echo ".env file not found!"
  exit 1
fi

# Sequentially call the individual scripts
bash scripts/install_deps.sh
bash scripts/issue_certificate.sh
bash scripts/download_xray.sh
bash scripts/replace_placeholders.sh