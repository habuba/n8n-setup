variable "hcloud_token" {
  type = string
}

variable "public_ssh_key_path" {
  type    = string
  default = "C:\\Users\\YOUR_USERNAME\\.ssh\\id_rsa.pub"
}

variable "server_type" {
  type    = string
  default = "cx22"
}

variable "location" {
  type    = string
  default = "hel1"
}