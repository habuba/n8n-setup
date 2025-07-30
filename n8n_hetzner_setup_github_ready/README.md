
# 🚀 n8n Hetzner Setup (Self-Hosted, Secure & Automated)

Easily deploy n8n on a Hetzner server with:
- ✅ Free SSL from Let's Encrypt (either with `nip.io` or your own domain)
- ✅ Auto-renewal of SSL via cron
- ✅ Auto-updates of the n8n Docker image via cron
- ✅ Preinstalled Python, yt-dlp, ffmpeg (YouTube transcription support)
- ✅ Preinstalled Community Nodes:
  - [`idobe977/n8n-nodes-whatsapp-green-api`](https://github.com/idobe977/n8n-nodes-whatsapp-green-api)
  - [`@endcycles/n8n-nodes-youtube-transcript`](https://www.npmjs.com/package/@endcycles/n8n-nodes-youtube-transcript)
  - [`t0mer/greenapi-n8n-router`](https://github.com/t0mer/greenapi-n8n-router) *(runs as separate service)* 🧱

---

## ⚡️ Quick Start – Using `nip.io` (No domain needed!)

```bash
apt update && apt install -y unzip curl git
curl -L https://github.com/<your-username>/n8n_hetzner_setup/releases/latest/download/n8n_hetzner_setup_final_autocron.zip -o setup.zip
unzip setup.zip && cd n8n_hetzner_setup
chmod +x install_with_nip.sh
./install_with_nip.sh
```

This will:
- Detect your server’s public IP
- Generate `your.ip.addr.nip.io`
- Request a Let's Encrypt cert
- Deploy n8n via Docker with HTTPS
- Install community nodes
- Add cron jobs to renew SSL and auto-update n8n

---

## 🌐 With Your Own Domain

Make sure your domain (e.g., `n8n.yourdomain.com`) points via A record to your server's public IP.

```bash
chmod +x install_with_domain.sh
./install_with_domain.sh n8n.yourdomain.com
```

---

## 🔁 Cron Jobs (Auto-Created)

After install, these are added automatically to root's crontab:

| Task | Frequency | Script |
|------|-----------|--------|
| SSL renewal | Weekly (Sun 03:00) | `/root/n8n/renew_ssl.sh <domain>` |
| n8n update  | Daily (04:00)      | `/root/n8n/update_n8n.sh`        |

Logs are saved under `/var/log/`.

---

## 📂 File Structure

```text
.
├── install_with_nip.sh           # Use nip.io dynamic domain
├── install_with_domain.sh        # Use your own domain
├── scripts/
│   ├── install_prereqs.sh
│   ├── gen_ssl_letsencrypt.sh
│   ├── deploy_n8n.sh
│   ├── install_community_nodes.sh
│   ├── renew_ssl.sh
│   ├── update_n8n.sh
│   └── setup_cron.sh
├── README.md                     # You're reading it!
├── CRON.md                       # Manual cron instructions (redundant)
```

---

## 🛠 Requirements

- Ubuntu 20.04+ / Debian 11+
- Root access (or `sudo`)
- Open ports: 80 (for Let's Encrypt), 443 (for HTTPS)
- Static IP

---

## 🧡 Credit

Created by [ChatGPT + Shell scripting] — ready to be hosted, customized, or forked.

Pull requests welcome.
