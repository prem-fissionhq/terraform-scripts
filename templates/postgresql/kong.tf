# Create a new Web Droplet in the nyc2 region
resource "digitalocean_droplet" "kong" {
  image  = "ubuntu-14-04-x64"
  name   = "Kong-Server"
  region = "nyc1"
  size   = "512mb"
  user_data = "${data.template_file.kong_install.rendered}"
  ssh_keys = [
	"${var.digitalocean_ssh_fingerprint}"
  ]
}

data "template_file" "kong_install" {
  template = "${file("${path.module}/konginstallation.tpl")}"
}

output "address_kong" {
  value = "${digitalocean_droplet.kong.ipv4_address}"
}

