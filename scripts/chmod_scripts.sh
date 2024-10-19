#!/bin/bash

chmod_scripts() {
    echo "Changing permissions for scripts..."
    cd ~/services
    chmod +x *.sh
}

chmod_scripts