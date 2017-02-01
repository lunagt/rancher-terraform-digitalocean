variable "do_token" {}
variable "pvt_key" {}
variable "ssh_fingerprint" {}

provider "digitalocean" {
   token = "${var.do_token}"
}
