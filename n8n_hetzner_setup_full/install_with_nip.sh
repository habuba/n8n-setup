#!/bin/bash
set -euo pipefail

#DOMAIN="$(curl -s https://api.ipify.org).nip.io"
DOMAIN="n8n.$(curl -s https://api.ipify.org).nip.io"
#DOMAIN="test-$(date +%s).$(curl -s https://api.ipify.org).nip.io"

echo "▶ Using dynamic domain: $DOMAIN"

mkdir -p /root/n8n

echo "$DOMAIN" > /root/n8n/domain.txt

echo "🔧 Installing prerequisites..."
./scripts/install_prereqs.sh

cp .env.example .env || true

./install_community_nodes.sh

sleep 10

echo "🔐 Generating SSL certificate..."
./scripts/gen_ssl_letsencrypt.sh "$DOMAIN" || {
    echo "❌ SSL generation failed"
    exit 1
}

GREEN_API_TOKEN=$(openssl rand -hex 16)

cat <<EOF > /root/n8n/.env
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=admin
N8N_BASIC_AUTH_PASSWORD=$(openssl rand -base64 16)
DOMAIN=$DOMAIN
EOF

echo "GREEN_API_TOKEN=$GREEN_API_TOKEN" >> /root/n8n/.env
chmod 600 /root/n8n/.env

mkdir -p /root/n8n/data
chown -R 1000:1000 /root/n8n/data

cp -r ./custom /root/n8n/ || true
cp -r ./ssl /root/n8n/ || true
mkdir -p /root/n8n/greenapi-router/config

echo "🔒 Fixing SSL permissions..."
./scripts/fix_ssl_permissions.sh

echo "🧩 Generating docker-compose.yml..."
./scripts/generate_compose.sh

echo "📁 Copying nginx config, htpasswd file, and reset script..."
cp ./nginx_greenapi.conf /root/n8n/ || true
cp ./greenapi.htpasswd /root/n8n/ || true
cp ./reset_greenapi_password.sh /root/n8n/ || true
chmod +x /root/n8n/reset_greenapi_password.sh



cd /root/n8n
docker compose down -v || true
docker compose up -d

cd /root/n8n-setup/n8n_hetzner_setup_full

echo "📅 Setting up SSL auto-renew cron job..."
./scripts/setup_cron.sh

echo "🟢 GreenAPI Router available at: http://$DOMAIN:3002"
echo "🔐 Token: $GREEN_API_TOKEN"
