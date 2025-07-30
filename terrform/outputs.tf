output "server_ip" {
  value = hcloud_server.n8n.ipv4_address
}

output "server_name" {
  value = hcloud_server.n8n.name
}