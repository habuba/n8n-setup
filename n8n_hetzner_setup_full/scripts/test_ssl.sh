#!/bin/bash
set -euo pipefail

DOMAIN=$(cat /root/n8n/domain.txt)
SSL_DIR="/root/n8n-setup/n8n_hetzner_setup_full/ssl"

echo "🔍 Checking if certificate files exist..."
if [[ -f "$SSL_DIR/n8n.crt" && -f "$SSL_DIR/n8n.key" ]]; then
  echo "✅ SSL files found."
else
  echo "❌ SSL files missing in $SSL_DIR"
  exit 1
fi

echo "🌐 Testing HTTPS connection to https://$DOMAIN ..."
curl -vk --max-time 10 https://$DOMAIN 2>&1 | grep "SSL connection"

echo "✅ Test complete. If no SSL errors above, certificate is active."
