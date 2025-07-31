#!/bin/bash
set -e

echo "🌍 Generating domain from IP..."
DOMAIN="$(curl -s https://api.ipify.org).nip.io"
echo "$DOMAIN" > /root/n8n/domain.txt
echo "✅ Domain saved: $DOMAIN"
