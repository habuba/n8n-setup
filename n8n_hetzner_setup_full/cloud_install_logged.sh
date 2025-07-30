#!/bin/bash
set -euo pipefail
LOGFILE=/root/n8n-install.log
exec > >(tee -a "$LOGFILE") 2>&1

echo "📦 Cloning setup repo..."
cd /root
git clone https://github.com/habuba/n8n-setup.git || true
cd n8n-setup/n8n_hetzner_setup_full

echo "🔐 Making scripts executable"
chmod +x install_with_nip.sh scripts/*.sh

echo "🚀 Running installation with NIP..."
./install_with_nip.sh