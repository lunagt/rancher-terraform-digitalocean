
resource "digitalocean_droplet" "host" {
    image = "coreos-stable"
    name = "${var.host_name}"
    region = "sfo1"
    size = "512mb"
    private_networking = "true"
    ssh_keys = [
      "${var.ssh_fingerprint}"
    ]

    connection {
      type = "ssh"
      user = "core"
      private_key = "${file(var.pvt_key)}"
      timeout = "2m"
    }
}

output "output-host" {
  value = "Host: ${digitalocean_droplet.host.ipv4_address} - ${digitalocean_droplet.host.ipv4_address_private}"
}
