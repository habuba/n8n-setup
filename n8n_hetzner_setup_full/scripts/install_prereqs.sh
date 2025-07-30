#!/bin/bash
set -e
echo "Installing prerequisites..."
apt-get update
apt-get install -y python3 python3-pip curl git unzip
