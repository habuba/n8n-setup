#!/bin/bash
set -e
echo "Running deploy_n8n.sh"
docker compose pull
docker compose up -d
