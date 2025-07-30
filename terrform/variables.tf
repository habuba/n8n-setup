variable "hcloud_token" {
  description = "Hetzner Cloud API token"
  type        = string
  sensitive   = true
}

variable "server_name" {
  description = "Name of the server"
  type        = string
  default     = "n8n-server"
}

variable "server_type" {
  description = "Hetzner server type"
  type        = string
  default     = "cx22"
}

variable "image" {
  description = "Image to use for the server"
  type        = string
  default     = "ubuntu-22.04"
}

variable "location" {
  description = "Location for the server"
  type        = string
  default     = "hel1"
}

variable "public_ssh_key_path" {
  description = "Path to the public SSH key to upload to Hetzner"
  type        = string
}
