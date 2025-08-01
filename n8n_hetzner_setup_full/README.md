# ⚙️ n8n Hetzner Auto-Install Scripts

This folder contains scripts to automate n8n installation on a Hetzner Ubuntu server.

## 📦 What It Does

- Installs Docker & certbot
- Generates dynamic domain (using `nip.io`)
- Issues a Let's Encrypt SSL certificate
- Deploys n8n via Docker Compose
- Installs optional community nodes
- Sets up cron job for SSL auto-renewal
- Generates `.env` with random basic auth password

## 🛠 Usage (Manual)

SSH into your Hetzner VM, then:

```bash
git clone https://github.com/habuba/n8n-setup.git /root/n8n-setup
cd /root/n8n-setup/n8n_hetzner_setup_full
chmod +x install_with_nip.sh scripts/*.sh
./install_with_nip.sh | tee /root/n8n-install.log
```

When done, n8n will be available at: `https://<your-ip>.nip.io`
