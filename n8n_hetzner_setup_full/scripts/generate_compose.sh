#!/bin/bash
set -e
DOMAIN=$(cat /root/n8n/domain.txt)
TEMPLATE_PATH="/root/n8n-setup/n8n_hetzner_setup_full/docker-compose.template.yml"
OUTPUT_PATH="/root/n8n/docker-compose.yml"

sed "s|\${DOMAIN}|$DOMAIN|g" "$TEMPLATE_PATH" > "$OUTPUT_PATH"
echo "✅ docker-compose.yml generated with domain: $DOMAIN"
