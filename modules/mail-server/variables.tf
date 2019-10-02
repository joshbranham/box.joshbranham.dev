variable "hostname" {
  description = "Hostname for the instance"
}

variable "ssh_key" {
  description = "SSH key ID"
}

variable "droplet_size" {
  description = "Droplet siz"
  default = "s-1vcpu-1gb"
}