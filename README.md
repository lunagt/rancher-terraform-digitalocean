# Rancher Terraform DigitalOcean
Terraform module for a rancher server on digitalocean.

### Variables

#### Mandatory DigitalOcean API Variables

| Variable         | Default | Description                                                    |
|------------------|---------|----------------------------------------------------------------|
| do\_token        | empty   | DigitalOcean Personal Access Token                             |
| pub\_key         | empty   | Public key location, so it can be installed into new droplets  |
| pvt\_key         | empty   | Private key location, so Terraform can connect to new droplets |
| ssh\_fingerprint | empty   | Fingerprint of SSH key                                         |

#### Mandatory Host Variables

| Variable                  | Default                       | Description                                                                 |
|---------------------------|-------------------------------|-----------------------------------------------------------------------------|
| domain                    | empty                         | Existing DigitalOcean DNS in which the host will be added e.g. example.com |


#### Optional Host Variables

| Variable                  | Default                       | Description                                                                 |
|---------------------------|-------------------------------|-----------------------------------------------------------------------------|
| host\_name                | rancher-server                | Name of the host to be created                                               |
| image                     | docker-16-04                  | Base image for the host                                                     |
| region                    | sfo1                          | Digital Ocean region for the host                                           |
| size                      | 1gb                           | Digital Ocean size of the host (512mb, 1gb, 2gb)                             |
| private\_networking       | true                          | Enable/Disable private networking                                           |
| domain\_name              | rancher.                      | Domain name, for example "rancher." (note the dot at the end), so you will have rancher.example.com|
| user                      | rancher                       | Username to be used to login to the host and for the home folder.     |
