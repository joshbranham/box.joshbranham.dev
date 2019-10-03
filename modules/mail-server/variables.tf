variable "droplet_size" {
  description = "Droplet size"
  default     = "s-1vcpu-1gb"
}

variable "hostname" {
  description = "Hostname for the instance"
}

variable "image" {
  default = "ubuntu-18-04-x64"
}

variable "mailinabox_version" {
  description = "Git release tag for mailinabox"
}

variable "pvt_key" {
  description = "Private key matchin ssh_key"
}

variable "region" {
  default = "nyc3"
}

variable "ssh_key" {
  description = "SSH key ID"
}