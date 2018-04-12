# Create a new Web Droplet in the nyc1 region
variable "number_of_servers"{
	default = 2
}


resource "digitalocean_droplet" "slave" {
  image  = "ubuntu-16-04-x64"
  name   = "${format("slave-%02d", count.index + 1)}"
  count  = "${var.number_of_servers}"
  region = "nyc1"
  size   = "1gb"
  user_data = "${data.template_file.slave_install.rendered}"
  ssh_keys = [
	"${var.digitalocean_ssh_fingerprint}"
  ]


}

data "template_file" "slave_install" {
  template = "${file("${path.module}/slave.tpl")}"
}

output "address_slave" {
  value = "${digitalocean_droplet.slave.*.ipv4_address}"
}

