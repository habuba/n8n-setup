#!/bin/bash

LOG_FILE="/root/n8n-install.log"
exec > >(tee -a "$LOG_FILE") 2>&1

set -e
trap 'echo "❌ Installation failed at line $LINENO"; exit 1' ERR

echo "🔧 Updating packages..."
apt update

echo "📦 Installing dependencies..."
apt install -y apt-transport-https ca-certificates curl gnupg lsb-release python3 python3-pip unzip

echo "🔑 Adding Docker GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "➕ Adding Docker repository..."
echo   "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu   $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "🔄 Updating after adding Docker repo..."
apt update

echo "🐳 Installing Docker..."
apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

echo "🚀 Starting Docker service..."
systemctl enable docker
systemctl start docker

echo "📁 Moving to setup directory..."
cd /root/n8n-setup/n8n_hetzner_setup_full

echo "🔓 Granting script permissions..."
chmod +x install_with_nip.sh scripts/*.sh

echo "▶ Running n8n installation..."
./install_with_nip.sh

echo "✅ n8n installation completed."