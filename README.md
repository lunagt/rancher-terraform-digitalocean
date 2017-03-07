![rancher][rancher]![terraform][terraform]![digitalocean][digitalocean]

# Rancher Terraform DigitalOcean
Terraform module for a rancher server on Digitalocean.

### What you will get?

- A Rancher server running on DigitalOcean
- A Domain rule pointing to your Rancher server

### Features

- It works with your main DigitalOcean account or with DigitalOcean teams. For using a team you just need that team special token and your SSH keys installed there.
- It doesn't install puppet, chef or ansible on the host. Instead it uses [cloud-init](https://cloudinit.readthedocs.io/en/latest/).
- It closes all the external and internal traffic and the only ports opened are the `80` and `8080`.
- Login with root user is disabled, you will need your SSH keys.
- Iptables rules are persistent after reboot.
- You will get the new DigitalOcean beta metrics agent installed.

### What you will need?

- Terraform installed. This was tested with the 0.8.5 version. You can see terraform instructions [here](https://www.terraform.io/downloads.html).
- A DigitalOcean account. If you still don't have one you can create one [here](https://m.do.co/c/503f13cf640b) for free.
- You DigitalOcean token. You can get it from [here](https://cloud.digitalocean.com/settings/api/tokens).
- Public and private SSH keys on your local machine and set them up on your Digital Ocean account. You can learn how to do that [here](https://www.digitalocean.com/community/tutorials/how-to-use-ssh-keys-with-digitalocean-droplets).

### How to use it

Clone this repository

    git clone git@github.com:lunagt/rancher-terraform-digitalocean.git

Inside the repository folder create a copy of the example `tfvars` file

    cp terraform.example.tfvars terraform.tfvars

Edit this new file with the variables you want (see `variables` section at the end).

Runing it

    terraform apply
    
If you don't need your server anymore, just destroy it

    terraform destroy #and type 'yes' after this command
    
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
| private\_networking       | false                         | Enable/Disable private networking                                           |
| domain\_name              | rancher.                      | Domain name, for example "rancher." (note the dot at the end), so you will have rancher.example.com|
| user                      | rancher                       | Username to be used to login to the host and for the home folder.     |

[rancher]: ./images/rancher-small.png
[terraform]: ./images/terraform-small.png
[digitalocean]: ./images/digitalocean-small.png
