# n8n Hetzner Setup (Auto Install)

This repository automates the setup of an `n8n` instance on a Hetzner Ubuntu server.

## Includes

- Docker + Docker Compose
- Python + pip + yt-dlp
- Community nodes:
  - `@endcycles/n8n-nodes-youtube-transcript`
  - `greenapi` (custom)
- Auto-deploy with `.nip.io` domain

## Usage with Terraform

Use the provided `cloud-init.yaml` with your `main.tf`. Example:

```
filename = "${path.module}/cloud-init.yaml"
```

## Manual Run (for testing)

```bash
chmod -R +x ./scripts
chmod +x install_with_nip.sh
./install_with_nip.sh
```
