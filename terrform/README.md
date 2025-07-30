# n8n Hetzner Self-Hosted Setup

This repository provides a complete cloud-init-compatible setup for running `n8n` self-hosted with Docker, HTTPS, and custom nodes.

## 🧰 Features

- n8n via Docker with SSL (nip.io)
- Auto-install community nodes
- Support for Python dependencies
- Custom `.env` and `docker-compose.yml`

## 📁 Structure

```
n8n_hetzner_setup_full/
├── .env.example
├── cloud_install_logged.sh
├── docker-compose.yml
├── install_with_nip.sh
├── scripts/
│   ├── deploy_n8n.sh
│   ├── gen_ssl_letsencrypt.sh
│   ├── install_community_nodes.sh
│   └── install_prereqs.sh
```

## 🚀 Usage

1. Deploy Hetzner cloud server with `cloud-init.yaml` (see below)
2. n8n will be available at `https://YOUR_SERVER_IP.nip.io`

## ☁️ cloud-init.yaml

```yaml
#cloud-config
package_update: true
packages:
  - unzip
  - curl
  - git
runcmd:
  - cd /root
  - apt update && apt install -y curl git unzip
  - curl -L https://raw.githubusercontent.com/habuba/n8n-setup/main/n8n_hetzner_setup_full/cloud_install_logged.sh -o cloud_install_logged.sh
  - chmod +x cloud_install_logged.sh
  - ./cloud_install_logged.sh
```
