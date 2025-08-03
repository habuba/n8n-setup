# n8n Hetzner Setup with SSL (nip.io)

This setup automates the deployment of an n8n server on Hetzner using a dynamic domain via nip.io.
It includes:

- Automatic SSL certificate issuance via Let's Encrypt
- Docker deployment with HTTPS support
- Daily cron job to auto-renew certificates
- Community nodes installation
- Verification script to test SSL

---

## 🧪 SSL Test Script

To verify SSL is active and functional, SSH into your server and run:

```bash
cd /root/n8n-setup/n8n_hetzner_setup_full
chmod +x scripts/test_ssl.sh
./scripts/test_ssl.sh
