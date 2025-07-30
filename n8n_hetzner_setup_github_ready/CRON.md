
# 🔁 Automatic Cron Jobs for SSL & n8n Updates

Add the following cron jobs to ensure SSL certificates and n8n version are always up-to-date.

---

## ✅ SSL Auto-Renewal (once a week)

```bash
(crontab -l 2>/dev/null; echo "0 3 * * 0 /root/n8n/renew_ssl.sh your.domain.com >> /var/log/n8n_ssl_renew.log 2>&1") | crontab -
```

**Replace** `your.domain.com` with your actual domain or nip.io domain.

---

## ✅ n8n Auto-Update (daily)

```bash
(crontab -l 2>/dev/null; echo "0 4 * * * /root/n8n/update_n8n.sh >> /var/log/n8n_update.log 2>&1") | crontab -
```

This will pull the latest Docker image and restart n8n.
