#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR=~/n8n
ROUTER_DIR="$PROJECT_DIR/greenapi-router"

echo "▶ Cloning greenapi-n8n-router..."
git clone --depth 1 https://github.com/t0mer/greenapi-n8n-router.git "$ROUTER_DIR"

echo "▶ Creating Docker Compose for router service..."
cat > "$ROUTER_DIR/docker-compose.yml" <<EOF
services:
  greenapi-router:
    image: node:20-alpine
    container_name: greenapi-router
    restart: always
    working_dir: /app
    volumes:
      - ./greenapi-router:/app
    command: sh -c "corepack enable pnpm && pnpm install --prod && pnpm start"
    ports:
      - "3002:3002"

EOF

cd "$ROUTER_DIR"
docker compose up -d

echo "✅ GreenAPI Router service is running on port 3002"
