
resource "digitalocean_droplet" "host" {
    image = "docker-16-04"
    name = "${var.host_name}"
    region = "sfo1"
    size = "1gb"
    private_networking = "true"
    ssh_keys = [
      "${var.ssh_fingerprint}"
    ]

    connection {
      type = "ssh"
      user = "root"
      private_key = "${file(var.pvt_key)}"
      timeout = "2m"
    }

    provisioner "remote-exec" {
      inline = [
        "sudo iptables -I INPUT 1 -i eth0 -p tcp --dport 8080 -j ACCEPT",
        "sudo /sbin/iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080",
        "sudo DEBIAN_FRONTEND=noninteractive apt-get -y install iptables-persistent",
        "sudo netfilter-persistent save",
        "sudo netfilter-persistent reload",
        "docker run -d -v /var/lib/mysql:/var/lib/mysql --restart=unless-stopped -p 8080:8080 rancher/server:stable"
        ]
      }
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
