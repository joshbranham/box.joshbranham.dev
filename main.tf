# Build a droplet to host email for joshbranham.dev

module "box_joshbranham_dev" {
  source = "./modules/mail-server"

  hostname           = "box.joshbranham.dev"
  mailinabox_version = "v0.43"
  pvt_key            = "~/Desktop/id_rsa"
  ssh_key            = "25449140"
}