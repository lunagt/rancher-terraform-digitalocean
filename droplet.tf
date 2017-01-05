
resource "digitalocean_droplet" "loadbalancer" {
    image = "ubuntu-16-04-x64"
    name = "luna-lb-1"
    region = "sfo1"
    size = "512mb"
    private_networking = "true"
    ssh_keys = ["${var.ssh_keys}"]

    connection {
      type = "ssh"
      user = "luna"
      key_file = "${var.pvt_key}"
    }
}

output "output-deis-lb" {
  value = "Load balancer: ${digitalocean_droplet.loadbalancer.ipv4_address} - ${digitalocean_droplet.loadbalancer.ipv4_address_private}"
}
