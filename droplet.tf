
resource "template_file" "userdata_init" {
    template = "${file("${path.module}/templates/init.tpl")}"

    vars {
      userdata_user = "${var.user}"
      userdata_sshkey = "${file(var.pub_key)}"
    }
}

resource "digitalocean_droplet" "host" {
    image = "${var.image}"
    name = "${var.host_name}"
    region = "${var.region}"
    size = "${var.size}"
    private_networking = "${var.private_networking}"
    ssh_keys = ["${var.ssh_fingerprint}"]
    user_data = "${template_file.userdata_init.rendered}"
}

resource "digitalocean_record" "host" {
  domain = "${var.domain}"
  type = "A"
  name = "${var.domain_name}"
  value = "${digitalocean_droplet.host.ipv4_address}"
}

output "output-host" {
  value = "Host: ${digitalocean_droplet.host.ipv4_address} - ${digitalocean_droplet.host.ipv4_address_private}"
}
