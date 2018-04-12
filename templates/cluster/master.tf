# Create a new Web Droplet in the nyc2 region
resource "digitalocean_droplet" "master" {
  image  = "ubuntu-16-04-x64"
  name   = "master"
  region = "nyc1"
  size   = "1gb"
  user_data = "${data.template_file.master_install.rendered}"
  ssh_keys = [
	"${var.digitalocean_ssh_fingerprint}"
  ]

}

data "template_file" "master_install" {
  template = "${file("${path.module}/master.tpl")}"
}

output "address_master" {
  value = "${digitalocean_droplet.master.ipv4_address}"
}

