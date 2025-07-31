#!/bin/bash
set -euo pipefail

DOMAIN=$(cat /root/n8n/domain.txt)
SSL_DIR="/root/n8n-setup/n8n_hetzner_setup_full/ssl"
RENEW_SCRIPT="/root/n8n-setup/n8n_hetzner_setup_full/scripts/renew_ssl.sh"

echo "📄 Creating renew_ssl.sh script..."
cat > "$RENEW_SCRIPT" <<EOF
#!/bin/bash
DOMAIN="$DOMAIN"
SSL_DIR="$SSL_DIR"

certbot renew --quiet --standalone

cp /etc/letsencrypt/live/\$DOMAIN/fullchain.pem "\$SSL_DIR/n8n.crt"
cp /etc/letsencrypt/live/\$DOMAIN/privkey.pem "\$SSL_DIR/n8n.key"

docker restart n8n
EOF

chmod +x "$RENEW_SCRIPT"

echo "🕒 Setting up daily cron job for certificate renewal..."
(crontab -l 2>/dev/null; echo "0 4 * * * $RENEW_SCRIPT >> /var/log/ssl_renew.log 2>&1") | crontab -
