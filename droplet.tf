resource "digitalocean_ssh_key" "luna-ssh-key" {
    name = "luna ssh key"
    public_key = "${file("${var.PUBLIC_SSH_KEY}")}"
}

resource "digitalocean_droplet" "loadbalancer" {
    image = "coreos-stable"
    name = "luna-lb-1"
    region = "sfo1"
    size = "512mb"
    private_networking = "true"
    ssh_keys = ["${digitalocean_ssh_key.luna-ssh-key.id}"]
}

output "output-deis-lb" {
  value = "Load balancer: ${digitalocean_droplet.loadbalancer.ipv4_address} - ${digitalocean_droplet.loadbalancer.ipv4_address_private}"
}
