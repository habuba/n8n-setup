#!/bin/bash
set -euo pipefail

echo "🔍 Diagnosing n8n installation..."

# Check Docker
echo -e "\n🐳 Docker Status:"
if command -v docker &>/dev/null; then
  docker version --format '{{.Server.Version}}' || echo "❌ Docker not responding"
else
  echo "❌ Docker not installed"
fi

# Check docker-compose
echo -e "\n📦 Docker Compose Status:"
if docker compose version &>/dev/null; then
  docker compose version
else
  echo "❌ Docker Compose not found"
fi

# Check running containers
echo -e "\n🚦 Running Containers:"
docker ps || echo "❌ Could not list containers"

# Check n8n logs
echo -e "\n📄 Last 30 log lines from n8n container:"
docker logs n8n --tail 30 || echo "❌ Could not retrieve logs for n8n"

# Check domain
echo -e "\n🌍 Domain:"
cat /root/n8n/domain.txt || echo "❌ Domain file missing"

# Check .env file
echo -e "\n🔐 .env contents:"
cat /root/n8n/.env || echo "❌ .env file missing"

# Check docker-compose.yml
echo -e "\n📑 docker-compose.yml exists:"
ls -l /root/n8n/docker-compose.yml || echo "❌ Missing docker-compose.yml"

# Check SSL certs
echo -e "\n🔐 SSL certificates:"
ls -l /root/n8n/ssl || echo "❌ Missing SSL certificate files"

# Check cron
echo -e "\n📅 Cron jobs:"
crontab -l || echo "❌ No cron jobs set"

# Check ports
echo -e "\n🌐 Port status:"
ss -tulpn | grep -E ':80|:443|:5678' || echo "❌ Ports 80/443/5678 not listening"

echo -e "\n✅ Diagnosis complete."
