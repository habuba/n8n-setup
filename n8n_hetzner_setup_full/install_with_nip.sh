#!/bin/bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

echo "▶ Using dynamic domain: $(curl -s https://api.ipify.org).nip.io"

cd "$(dirname "$0")"

echo "🔧 Installing prerequisites..."
./scripts/install_prereqs.sh

echo "🔌 Pulling docker images (non-interactive)..."
docker compose pull || true

echo "🔁 Copying env example if missing..."
[ ! -f .env ] && cp -f .env.example .env

echo "📦 Installing community nodes..."
./scripts/install_community_nodes.sh

echo "🚀 Deploying n8n..."
docker compose down --remove-orphans
docker compose up -d

echo "✅ n8n installation completed successfully"