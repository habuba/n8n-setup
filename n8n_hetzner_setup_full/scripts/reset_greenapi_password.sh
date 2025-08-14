#!/bin/bash
set -euo pipefail

HTPASSWD_FILE="/root/n8n/greenapi.htpasswd"

read -p "👤 Enter username to reset (default: greenuser): " USERNAME
USERNAME=${USERNAME:-greenuser}

read -s -p "🔐 Enter new password: " PASSWORD
echo
read -s -p "🔐 Confirm password: " PASSWORD_CONFIRM
echo

if [[ "$PASSWORD" != "$PASSWORD_CONFIRM" ]]; then
  echo "❌ Passwords do not match!"
  exit 1
fi

if ! command -v htpasswd &> /dev/null; then
  echo "📦 Installing apache2-utils..."
  apt-get update && apt-get install -y apache2-utils
fi

echo "🔄 Updating password for user '$USERNAME'..."
htpasswd -b "$HTPASSWD_FILE" "$USERNAME" "$PASSWORD"

echo "🔁 Restarting greenapi-ssl service..."
docker restart greenapi-ssl

echo "✅ Password updated successfully for user '$USERNAME'"
