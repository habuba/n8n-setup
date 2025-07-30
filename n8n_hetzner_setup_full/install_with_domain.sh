#!/usr/bin/env bash
set -euo pipefail
DOMAIN=${1:-}
if [[ -z "$DOMAIN" ]]; then
  echo "❌ Missing domain. Usage: ./install_with_domain.sh your.domain.com"
  exit 1
fi
cd "$(dirname "$0")/scripts"
./install_prereqs.sh
./gen_ssl_letsencrypt.sh "$DOMAIN"
./deploy_n8n.sh "$DOMAIN"
./install_community_nodes.sh
echo "✅ n8n is running at https://$DOMAIN"
