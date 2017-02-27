variable "do_token" {}
variable "pub_key" {}
variable "pvt_key" {}
variable "ssh_fingerprint" {}
variable "domain" {}
variable "domain_name" {}
variable "host_name" { default = "rancher-server"}
variable "image" { default = "docker-16-04"}
variable "region" { default = "sfo1"}
variable "size" { default = "1gb"}
variable "private_networking" { default = "false"}
variable "user" { default = "rancher"}

provider "digitalocean" {
   token = "${var.do_token}"
}
