#!/bin/bash
set -e
echo "🚀 Running install_community_nodes.sh"

# לוודא ש-pip ו-yt-dlp מעודכנים
pip install -U pip yt-dlp

# הגדרת ספרייה מותאמת להרחבות
CUSTOM_DIR="/root/n8n/custom"

mkdir -p $CUSTOM_DIR/node_modules
cd $CUSTOM_DIR

echo "📦 Installing n8n community nodes..."

# מתקין SQLite node
if [ ! -d "$CUSTOM_DIR/node_modules/n8n-nodes-sqlite" ]; then
  npm install n8n-nodes-sqlite --legacy-peer-deps || true
  echo "✅ n8n-nodes-sqlite installed"
else
  echo "ℹ️ n8n-nodes-sqlite already exists, skipping"
fi

# כאן אפשר להוסיף הרחבות נוספות בעתיד
# if [ ! -d "$CUSTOM_DIR/node_modules/n8n-nodes-gpt" ]; then
#   npm install n8n-nodes-gpt --legacy-peer-deps || true
#   echo "✅ n8n-nodes-gpt installed"
# fi

echo "🎉 Finished install_community_nodes.sh"
