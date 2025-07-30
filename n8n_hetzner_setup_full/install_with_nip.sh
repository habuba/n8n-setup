#!/bin/bash
set -e
echo "▶ Using dynamic domain: $(curl -s https://api.ipify.org).nip.io"
echo "🔧 Installing prerequisites..."
./scripts/install_prereqs.sh
echo "🔁 Copying env example if missing..."
cp .env.example .env || true
echo "📦 Installing community nodes..."
./install_community_nodes.sh
echo "🚀 Deploying n8n..."
./scripts/deploy_n8n.sh
