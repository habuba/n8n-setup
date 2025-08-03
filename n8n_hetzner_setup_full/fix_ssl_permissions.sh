#!/bin/bash
set -e

SSL_DIR="/root/n8n/ssl"
chown root:1000 "$SSL_DIR/n8n.key"
chmod 640 "$SSL_DIR/n8n.key"
chmod 755 "$SSL_DIR"

echo "✅ Permissions on SSL files fixed."
