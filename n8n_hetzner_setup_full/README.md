# n8n Hetzner Setup (nip.io OR custom domain)

Deploy n8n on a Hetzner server with Docker + SSL (Let's Encrypt) using:

- Dynamic domain via `nip.io` (based on server IP) ✅
- OR your own domain (e.g. `n8n.yourdomain.com`) ✅
- Dockerized n8n with auto-restart
- Python + yt-dlp + ffmpeg for YouTube support
- Community nodes:
  - green-api
  - youtube-transcript
  - greenapi-n8n-router

---

## 🚀 Option 1: Install with IP-based domain via nip.io

_No domain needed — just run:_

```bash
apt update && apt install -y unzip curl git
curl -L https://github.com/YOUR_USER/n8n_hetzner_setup/releases/latest/download/n8n_hetzner_setup.zip -o setup.zip
unzip setup.zip && cd n8n_hetzner_setup
chmod +x install_with_nip.sh
./install_with_nip.sh
```

---

## 🌐 Option 2: Install using your own domain

_Requires domain pointing to your Hetzner IP via A record._

```bash
chmod +x install_with_domain.sh
./install_with_domain.sh n8n.yourdomain.com
```
