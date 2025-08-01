#!/bin/bash
set -euo pipefail

echo "🌍 Fetching IP and building domain..."
DOMAIN="$(curl -s https://api.ipify.org).nip.io"
echo "▶ Using dynamic domain: $DOMAIN"

mkdir -p /root/n8n
echo "$DOMAIN" > /root/n8n/domain.txt
echo "✅ Domain saved to /root/n8n/domain.txt"

cd "$(dirname "$0")"

# FIX: ensure install_community_nodes.sh is executable
chmod +x ./install_community_nodes.sh

echo "🔧 Installing prerequisites..."
./scripts/install_prereqs.sh

echo "📄 Copying env file if missing..."
cp .env.example .env || true

echo "📦 Installing community nodes..."
./install_community_nodes.sh

echo "⏳ Waiting 10 seconds before SSL (for network/DNS readiness)..."
sleep 10

echo "🔐 Generating SSL certificate..."
./scripts/gen_ssl_letsencrypt.sh "$DOMAIN" || {
    echo "❌ SSL generation failed"
    exit 1
}

echo "🔑 Creating .env file for n8n..."
cat <<EOF > /root/n8n/.env
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=admin
N8N_BASIC_AUTH_PASSWORD=$(openssl rand -base64 16)
EOF
chmod 600 /root/n8n/.env

echo "🚀 Deploying n8n..."
./scripts/deploy_n8n.sh

echo "🕒 Setting up auto-renewal cron..."
./scripts/setup_cron.sh
