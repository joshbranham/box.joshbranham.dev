output "mail_server_ip" {
  description = "IP of the droplet"
  value       = "${digitalocean_droplet.mail_server.ipv4_address}"
}