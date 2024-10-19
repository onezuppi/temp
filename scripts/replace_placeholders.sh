#!/bin/bash

# Задаем значения переменных
DOMAIN="ikanam.tech"
FAKE_SITE="https://longdogechallenge.com"
PANEL_SUBDOMAIN="hidden"
SUB_SUBDOMAIN="sub"

# Создаем временный Python-скрипт для замены переменных
cat << EOF > replace_vars.py
DOMAIN = "$DOMAIN"
FAKE_SITE = "$FAKE_SITE"
PANEL_SUBDOMAIN = "$PANEL_SUBDOMAIN"
SUB_SUBDOMAIN = "$SUB_SUBDOMAIN"

nginx_conf_template = "nginx/nginx.conf.template"
nginx_conf = "nginx/nginx.conf"

with open(nginx_conf_template, 'r') as template_file:
    config_data = template_file.read()

config_data = config_data.replace("\$DOMAIN", DOMAIN)
config_data = config_data.replace("\$FAKE_SITE", FAKE_SITE)
config_data = config_data.replace("\$PANEL_SUBDOMAIN", PANEL_SUBDOMAIN)
config_data = config_data.replace("\$SUB_SUBDOMAIN", SUB_SUBDOMAIN)

with open(nginx_conf, 'w') as config_file:
    config_file.write(config_data)

print("nginx.conf updated with domain-specific entries.")
EOF

# Запускаем Python-скрипт
python3 replace_vars.py

# Удаляем временный Python-скрипт
rm replace_vars.py
