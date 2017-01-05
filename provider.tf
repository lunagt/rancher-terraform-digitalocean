variable "do_token" {}
variable "pvt_key" {}
variable "ssh_keys" {}

provider "digitalocean" {
   token = "${var.do_token}"
}
