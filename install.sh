#!/bin/bash

# Sequentially call the individual scripts
bash scripts/install_deps.sh
bash scripts/issue_certificate.sh
bash scripts/download_xray.sh
bash scripts/replace_placeholders.sh