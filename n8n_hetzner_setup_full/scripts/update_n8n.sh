#!/usr/bin/env bash
set -euo pipefail

echo "▶ Pulling latest n8n image..."
docker pull n8nio/n8n:latest

echo "▶ Recreating n8n container..."
cd ~/n8n
docker compose down && docker compose up -d

echo "✅ n8n updated successfully."
