
resource "template_file" "userdata_init" {
    template = "${file("${path.module}/templates/init.tpl")}"

    vars {
       userdata_sshkey = "${file(var.pub_key)}"
    }
}

resource "digitalocean_droplet" "host" {
    image = "docker-16-04"
    name = "${var.host_name}"
    region = "sfo1"
    size = "1gb"
    private_networking = "true"
    ssh_keys = ["${var.ssh_fingerprint}"]
    user_data = "${template_file.userdata_init.rendered}"
}

#resource "digitalocean_record" "host" {
#  domain = "${var.domain}"
#  type = "A"
#  name = "${var.domain_name}"
#  value = "${digitalocean_droplet.host.ipv4_address}"
#}

output "output-host" {
  value = "Host: ${digitalocean_droplet.host.ipv4_address} - ${digitalocean_droplet.host.ipv4_address_private}"
}
