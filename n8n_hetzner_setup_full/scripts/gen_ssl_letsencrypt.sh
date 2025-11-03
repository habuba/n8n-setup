#!/bin/bash
set -euo pipefail

DOMAIN="${1:-}"
EMAIL="admin@$DOMAIN"
SSL_DIR="/root/n8n/ssl"

if [[ -z "$DOMAIN" ]]; then
  echo "❌ No domain provided"
  exit 1
fi

echo "🔐 Installing certbot..."
apt-get update
apt-get install -y certbot

echo "📁 Creating SSL folder: $SSL_DIR"
mkdir -p "$SSL_DIR"

echo "📡 Stopping n8n if running (port 80 needed)..."
docker stop n8n || true

echo "📄 Generating certificate for $DOMAIN..."
certbot certonly --standalone --non-interactive --agree-tos -m "$EMAIL" -d "$DOMAIN"

echo "📦 Copying certs to $SSL_DIR"
cp /etc/letsencrypt/live/"$DOMAIN"/fullchain.pem "$SSL_DIR"/n8n.crt || true
cp /etc/letsencrypt/live/"$DOMAIN"/privkey.pem "$SSL_DIR"/n8n.key || true

if [[ -f "$SSL_DIR/n8n.crt" && -f "$SSL_DIR/n8n.key" ]]; then
  echo "✅ SSL certificate successfully created and copied for $DOMAIN"
else
  echo "❌ SSL certificate creation failed! Cert files not found in $SSL_DIR"
  exit 1
fi

echo "🔁 Starting n8n again..."
docker start n8n || true

echo "🎉 Done."
