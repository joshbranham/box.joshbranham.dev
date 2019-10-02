module "box_joshbranham_dev" {
  source = "./modules/mail-server"
  hostname = "foobar"
  ssh_key  = "25449140"
}