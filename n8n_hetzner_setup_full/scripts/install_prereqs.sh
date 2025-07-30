#!/bin/bash
set -e

echo "🐍 Installing Python requirements..."

apt update -y
apt install -y python3 python3-pip

pip3 install --upgrade pip
pip3 install yt-dlp

echo "✅ Python and yt-dlp installed"
