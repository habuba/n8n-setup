terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
  version = "~> 1.45"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}

resource "hcloud_ssh_key" "default" {
  name       = "windows-ssh-key"
  public_key = file(var.public_ssh_key_path)
}

resource "hcloud_server" "n8n" {
  name        = "n8n-server"
  image       = "ubuntu-22.04"
  server_type = var.server_type
  location    = var.location
  ssh_keys    = [hcloud_ssh_key.default.id]
  user_data   = file("cloud-init.yaml")
}




resource "hcloud_firewall" "n8n_firewall" {
  name = "n8n-firewall"

  rule {
    direction  = "in"
  protocol   = "tcp"
    port       = "22"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  rule {
    direction  = "in"
  protocol   = "tcp"
    port       = "80"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  rule {
    direction  = "in"
  protocol   = "tcp"
    port       = "443"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  rule {
    direction  = "in"
  protocol   = "tcp"
    port       = "3002"
    source_ips = ["0.0.0.0/0", "::/0"]
  }
}
