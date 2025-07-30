#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR=~/n8n
CUSTOM_DIR="$PROJECT_DIR/custom"
NODE_UID_GID="1000:1000"

mkdir -p "$CUSTOM_DIR"
cd "$CUSTOM_DIR"

sudo chown -R $USER:$USER "$CUSTOM_DIR"

git clone --depth 1 https://github.com/idobe977/n8n-nodes-whatsapp-green-api.git || true
cd n8n-nodes-whatsapp-green-api
docker run --rm -v "$(pwd)":/work -w /work node:20-alpine sh -c 'corepack enable pnpm && pnpm install --prod --silent && (jq -e ".scripts.build" package.json >/dev/null 2>&1 && pnpm run build || true)'
cd ..

git clone --depth 1 https://github.com/endcycles/n8n-nodes-youtube-transcript.git || true
cd n8n-nodes-youtube-transcript
docker run --rm -v "$(pwd)":/work -w /work node:20-alpine sh -c 'corepack enable pnpm && pnpm install --prod --silent'
cd ..

git clone --depth 1 https://github.com/t0mer/greenapi-n8n-router.git || true
cd greenapi-n8n-router
docker run --rm -v "$(pwd)":/work -w /work node:20-alpine sh -c 'corepack enable pnpm && pnpm install --prod --silent && (jq -e ".scripts.build" package.json >/dev/null 2>&1 && pnpm run build || true)'
cd ..

sudo chown -R "$NODE_UID_GID" "$CUSTOM_DIR"
cd "$PROJECT_DIR"
docker compose up -d