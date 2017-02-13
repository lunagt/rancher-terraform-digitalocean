
resource "digitalocean_droplet" "host" {
    image = "coreos-stable"
    name = "${var.host_name}"
    region = "sfo1"
    size = "1gb"
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

    provisioner "remote-exec" {
      inline = [
        "sudo iptables -I INPUT 1 -i eth0 -p tcp --dport 8080 -j ACCEPT",
        "docker run -d --restart=unless-stopped -p 8080:8080 rancher/server:stable"
        ]
      }
}

resource "digitalocean_record" "a_digital_ocean_host" {
  domain = "${var.domain}"
  type = "A"
  name = "${var.domain_name}"
  value = "${digitalocean_droplet.digitalocean_host.ipv4_address}"
}

output "output-host" {
  value = "Host: ${digitalocean_droplet.host.ipv4_address} - ${digitalocean_droplet.host.ipv4_address_private}"
}
