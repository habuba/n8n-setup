#!/usr/bin/env bash
set -euo pipefail

DOMAIN=$(cat /root/n8n/domain.txt)

crontab -l 2>/dev/null | grep -v "renew_ssl.sh" | grep -v "update_n8n.sh" > /tmp/cron.tmp || true

echo "0 3 * * 0 /root/n8n/renew_ssl.sh $DOMAIN >> /var/log/n8n_ssl_renew.log 2>&1" >> /tmp/cron.tmp
echo "0 4 * * * /root/n8n/update_n8n.sh >> /var/log/n8n_update.log 2>&1" >> /tmp/cron.tmp

crontab /tmp/cron.tmp
rm /tmp/cron.tmp

echo "✅ Cron jobs installed for SSL renewal and n8n update"
