variable "do_token" {}
variable "pub_key" {}
variable "pvt_key" {}
variable "ssh_fingerprint" {}
variable "host_name" {}
variable "domain" {}
variable "domain_name" {}

provider "digitalocean" {
   token = "${var.do_token}"
}
