#!/usr/bin/env bash
set -euo pipefail
DOMAIN=${1:-}
if [[ -z "$DOMAIN" ]]; then
  echo "Usage: $0 your-domain.example.com"
  exit 1
fi
sudo apt-get update
sudo apt-get install -y snapd
sudo snap install core && sudo snap refresh core
sudo snap install --classic certbot
sudo ln -sf /snap/bin/certbot /usr/bin/certbot
echo "▶ Stopping any service on port 80 temporarily..."
sudo docker ps --filter "name=n8n" -q | xargs -r sudo docker stop
echo "▶ Requesting certificate for $DOMAIN..."
sudo certbot certonly --standalone -d "$DOMAIN" --non-interactive --agree-tos -m "admin@$DOMAIN"
CERT_SRC=/etc/letsencrypt/live/$DOMAIN
CERT_DIR=~/n8n/ssl
mkdir -p "$CERT_DIR"
sudo cp "$CERT_SRC/fullchain.pem" "$CERT_DIR/n8n.crt"
sudo cp "$CERT_SRC/privkey.pem" "$CERT_DIR/n8n.key"
sudo chown 1000:1000 "$CERT_DIR/n8n."{crt,key}
sudo chmod 600 "$CERT_DIR/n8n."{crt,key}
echo "✅ SSL cert installed for $DOMAIN"
