#!/usr/bin/env bash
set -e
DOMAIN=${1:-localhost}
PROJECT=~/n8n
mkdir -p "$PROJECT"/{data,custom,ssl}
cat > "$PROJECT/docker-compose.yml" <<EOF
services:
  n8n:
    image: n8nio/n8n:latest
    container_name: n8n
    user: "1000:1000"
    restart: always
    ports:
      - "443:5678"
    environment:
      - N8N_PROTOCOL=https
      - N8N_SSL_KEY=/files/ssl/n8n.key
      - N8N_SSL_CERT=/files/ssl/n8n.crt
      - N8N_HOST=$DOMAIN
      - WEBHOOK_URL=https://$DOMAIN/
      - N8N_EDITOR_BASE_URL=https://$DOMAIN/
      - GENERIC_TIMEZONE=Asia/Jerusalem
      - N8N_CUSTOM_EXTENSIONS=/files/custom
      - N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true
      - N8N_DISABLE_PRODUCTION_MAIN_PROCESS=true
    volumes:
      - ./data:/home/node/.n8n
      - ./ssl:/files/ssl:ro
      - ./custom:/files/custom
EOF
cd "$PROJECT"
docker compose pull
docker compose up -d
