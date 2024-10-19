#!/bin/bash

# Функция для замены плейсхолдеров в конфигурации NGINX
replace_placeholders() {
    NGINX_CONF_TEMPLATE="nginx/nginx-template.conf"  # Шаблонный файл
    NGINX_CONF="nginx/nginx.conf"                   # Результирующий файл
    ENV_FILE=".env"                                 # Файл с переменными

    # Загружаем переменные из .env
    if [ -f "$ENV_FILE" ]; then
        export $(grep -v '^#' "$ENV_FILE" | xargs)
    else
        echo "Файл $ENV_FILE не найден!"
        exit 1
    fi

    # Используем sed для замены только необходимых переменных
    sed -e "s|\${DOMAIN}|$DOMAIN|g" \
        -e "s|\${FAKE_SITE}|$FAKE_SITE|g" \
        -e "s|\${PANEL_SUBDOMAIN}|$PANEL_SUBDOMAIN|g" \
        -e "s|\${SUB_SUBDOMAIN}|$SUB_SUBDOMAIN|g" \
        "$NGINX_CONF_TEMPLATE" > "$NGINX_CONF"

    echo "nginx.conf updated with domain-specific entries."
}

# Вызов функции
replace_placeholders
