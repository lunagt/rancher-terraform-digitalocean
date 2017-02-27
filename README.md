# Rancher Terraform DigitalOcean
Terraform module for a rancher server on digitalocean.

### Variables

#### DigitalOcean API

| Variable         | Default | Description                                                    |
|------------------|---------|----------------------------------------------------------------|
| do\_token        | empty   | DigitalOcean Personal Access Token                             |
| pub\_key         | empty   | Public key location, so it can be installed into new droplets  |
| pvt\_key         | empty   | Private key location, so Terraform can connect to new droplets |
| ssh\_fingerprint | empty   | Fingerprint of SSH key                                         |

