#!/bin/bash

# Загрузка и распаковка Xray-core
download_and_extract_xray() {
    ARCH_SUFFIX="64"
    DOWNLOAD_URL="https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-$ARCH_SUFFIX.zip"

    TMP_DIR=$(mktemp -d)
    ZIP_FILE="$TMP_DIR/Xray-linux-$ARCH_SUFFIX.zip"

    curl -L -o "$ZIP_FILE" "$DOWNLOAD_URL"
    unzip -q "$ZIP_FILE" -d xray/
    rm -rf "$TMP_DIR"

    echo "Xray-core downloaded and extracted successfully."
}

download_and_extract_xray
