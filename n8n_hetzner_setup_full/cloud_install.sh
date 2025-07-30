#!/bin/bash

set -e

apt update
apt install -y apt-transport-https ca-certificates curl gnupg lsb-release python3 python3-pip unzip

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo   "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu   $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update
apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

systemctl enable docker
systemctl start docker

cd /root/n8n-setup/n8n_hetzner_setup_full
chmod +x install_with_nip.sh scripts/*.sh
./install_with_nip.sh