#!/bin/bash
set -e

DOMAIN="$(curl -s https://api.ipify.org).nip.io"
echo "▶ Using dynamic domain: $DOMAIN"
echo "$DOMAIN" > /root/n8n/domain.txt

echo "🔧 Installing prerequisites..."
./scripts/install_prereqs.sh

echo "🔁 Copying env example if missing..."
cp .env.example .env || true

echo "📦 Installing community nodes..."
./install_community_nodes.sh

echo "🔐 Generating SSL certificate..."
./scripts/gen_ssl_letsencrypt.sh "$DOMAIN"

echo "🚀 Deploying n8n..."
./scripts/deploy_n8n.sh

echo "🕒 Setting up auto-renewal cron..."
./scripts/setup_cron.sh
