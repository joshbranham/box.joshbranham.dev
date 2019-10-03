resource "digitalocean_droplet" "mail_server" {
  image    = var.image
  name     = var.hostname
  region   = var.region
  size     = var.droplet_size
  ssh_keys = [var.ssh_key]

  provisioner "remote-exec" {
    inline = [
      "DEBIAN_FRONTEND=noninteractive apt-get -y upgrade",
      "git clone https://github.com/mail-in-a-box/mailinabox",
      "cd mailinabox",
      "git checkout ${var.mailinabox_version}"
    ]

    connection {
      type        = "ssh"
      host        = digitalocean_droplet.mail_server.ipv4_address
      user        = "root"
      private_key = "${file(var.pvt_key)}"
      timeout     = "2m"
    }
  }
}

resource "digitalocean_firewall" "mail_server" {
  name = "${var.hostname}-firewall"

  droplet_ids = ["${digitalocean_droplet.mail_server.id}"]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "25"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "587"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "993"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "995"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "4190"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

provider "digitalocean" {
  version = "~> 1.8"
}