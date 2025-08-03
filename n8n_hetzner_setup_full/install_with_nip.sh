#!/bin/bash
set -euo pipefail

echo "🌍 Fetching IP and building unique domain..."
#DOMAIN="test-$(date +%s).$(curl -s https://api.ipify.org).nip.io"
DOMAIN="$(curl -s https://api.ipify.org).nip.io"
echo "▶ Using dynamic domain: $DOMAIN"

mkdir -p /root/n8n
echo "$DOMAIN" > /root/n8n/domain.txt
echo "✅ Domain saved to /root/n8n/domain.txt"

cd "$(dirname "$0")"

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

echo "📁 Copying docker-compose.yml..."
cp docker-compose.yml /root/n8n/docker-compose.yml

echo "📁 Creating data folder with correct permissions..."
mkdir -p /root/n8n/data
chown -R 1000:1000 /root/n8n/data

echo "📁 Copying custom and ssl folders..."
cp -r ./custom /root/n8n/ || true
cp -r ./ssl /root/n8n/ || true

echo "🚀 Deploying n8n..."
cd /root/n8n
docker compose down -v || true
docker compose up -d

echo "🕒 Setting up auto-renewal cron..."
cd /root/n8n-setup/n8n_hetzner_setup_full
./scripts/setup_cron.sh
