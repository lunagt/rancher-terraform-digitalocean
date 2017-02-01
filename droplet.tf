
resource "digitalocean_droplet" "loadbalancer" {
    image = "ubuntu-16-04-x64"
    name = "test"
    region = "sfo1"
    size = "512mb"
    private_networking = "true"
    ssh_keys = [
      "${var.ssh_fingerprint}"
    ]

    connection {
      type = "ssh"
      user = "root"
      key_file = "${var.pvt_key}"
      timeout = "2m"
    }
}

output "output-deis-lb" {
  value = "Load balancer: ${digitalocean_droplet.loadbalancer.ipv4_address} - ${digitalocean_droplet.loadbalancer.ipv4_address_private}"
}
