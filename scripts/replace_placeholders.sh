#!/bin/bash

# Замена плейсхолдеров в файлах конфигурации
replace_placeholders() {
    NGINX_CONF="nginx/nginx.conf"
    ENV_FILE=".env"

    sed -i "s/my_domain\.com/$DOMAIN/g" "marzban/templates/singbox/default.json"
    sed -i "s/panel\.my_domain\.com/${PANEL_SUBDOMAIN}.${DOMAIN}/g" "$NGINX_CONF"
    sed -i "s/sub\.my_domain\.com/${SUB_SUBDOMAIN}.${DOMAIN}/g" "$NGINX_CONF"
    sed -i "s|/sub/|$LOCATION_PATH|g" "$NGINX_CONF"

    echo "nginx.conf updated with domain-specific entries."
}

replace_placeholders
