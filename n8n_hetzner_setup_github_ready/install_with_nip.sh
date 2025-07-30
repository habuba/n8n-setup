#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/scripts"
IP=$(curl -s https://checkip.amazonaws.com)
DOMAIN="$IP.nip.io"
echo "▶ Using dynamic domain: $DOMAIN"
./install_prereqs.sh
./gen_ssl_letsencrypt.sh "$DOMAIN"
./deploy_n8n.sh "$DOMAIN"
./install_community_nodes.sh
echo "✅ n8n is running at https://$DOMAIN"

echo "$DOMAIN" > /root/n8n/domain.txt
scripts/setup_cron.sh

scripts/install_greenapi_router.sh
