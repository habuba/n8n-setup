# Hetzner n8n Auto-Provision with Terraform & Cloud-Init

This project automates the deployment of an [n8n](https://n8n.io) server on a Hetzner Cloud VM using **Terraform** and **cloud-init**.

The setup includes:

- 🐳 Docker & Docker Compose installation
- 🐍 Python 3 + pip installation
- 🔄 Git clone of your custom n8n setup repository
- 🌐 Auto HTTPS with `nip.io` using your dynamic public IP
- 🚀 Full automatic execution of `install_with_nip.sh` from your GitHub repo

---

## 📁 Project Structure

```bash
.
├── main.tf                # Terraform configuration for Hetzner VM
├── variables.tf           # Input variables (token, ssh key path, etc.)
├── terraform.tfvars       # Your actual values (not committed if private)
├── cloud-init.yaml        # Boot-time configuration (uses your GitHub setup)
└── cloud_install.sh       # Script to install Docker, Python, and launch n8n
```

---

## 🚀 Quick Start

### 1. Prerequisites

- Hetzner Cloud account with API token
- SSH public key (`id_rsa.pub`) already generated
- Terraform installed on your local machine
- PuTTY or OpenSSH client for connecting to the server

### 2. Clone this Repo and Configure

```bash
git clone https://github.com/YOUR_USERNAME/n8n-hetzner-terraform.git
cd n8n-hetzner-terraform
```

Edit `terraform.tfvars` and update:

```hcl
hcloud_token         = "your_hetzner_token_here"
public_ssh_key_path  = "C:\\Users\\yourname\\.ssh\\id_rsa.pub"
server_type          = "cx22"
```

---

### 3. Deploy the Server

```bash
terraform init
terraform apply
```

After 2–4 minutes, the server will be ready.

---

## 🔗 Access n8n

Once the server is up, access your n8n instance at:

```
https://<server-ip>.nip.io
```

> Example: `https://37.27.89.162.nip.io`

---

## 🛠 Custom Setup Repo

This project pulls your installation scripts from:

```
https://github.com/habuba/n8n-setup/tree/main/n8n_hetzner_setup_full
```

Make sure the following file exists and is executable:

- `cloud_install.sh` ← The installer executed by cloud-init

---

## 🧰 License

MIT License © 2025 @habuba