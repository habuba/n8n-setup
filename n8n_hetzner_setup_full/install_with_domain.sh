#!/usr/bin/env bash
set -euo pipefail

DOMAIN=${1:-}
if [[ -z "$DOMAIN" ]]; then
  echo "❌ Missing domain. Usage: ./install_with_domain.sh your.domain.com"
  exit 1
fi

cd "$(dirname "$0")"

mkdir -p /root/n8n

./scripts/install_prereqs.sh

cp .env.example .env || true

./install_community_nodes.sh

sleep 10

./scripts/gen_ssl_letsencrypt.sh "$DOMAIN"
echo "$DOMAIN" > /root/n8n/domain.txt

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

./scripts/fix_ssl_permissions.sh
./scripts/generate_compose.sh


echo "📁 Copying nginx config, htpasswd file, and reset script..."
cp ./nginx_greenapi.conf /root/n8n/ || true
cp ./greenapi.htpasswd /root/n8n/ || true
cp ./reset_greenapi_password.sh /root/n8n/ || true
chmod +x /root/n8n/reset_greenapi_password.sh


cd /root/n8n
docker compose down -v || true
docker compose up -d --build

chown -R 1000:1000 ~/n8n/sqlite

cd /root/n8n-setup/n8n_hetzner_setup_full
./scripts/setup_cron.sh

echo "✅ n8n is running at https://$DOMAIN"
echo "🟢 GreenAPI Router available at: http://$DOMAIN:3002"
echo "🔐 Token: $GREEN_API_TOKEN"
