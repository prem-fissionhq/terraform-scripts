# Create a new Web Droplet in the nyc2 region
resource "digitalocean_droplet" "postgresdb" {
  image  = "ubuntu-14-04-x64"
  name   = "Postgresql-DB"
  region = "nyc1"
  size   = "512mb"
  user_data = "${data.template_file.postgres_install.rendered}"
  ssh_keys = [
	"${var.digitalocean_ssh_fingerprint}"
  ]
}

data "template_file" "postgres_install" {
  template = "${file("${path.module}/postgres_install.tpl")}"
}

output "address_postgres" {
  value = "${digitalocean_droplet.postgresdb.ipv4_address}"
}

