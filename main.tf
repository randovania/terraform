terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Set the variable value in *.tfvars file
# or using -var="do_token=..." CLI option
variable "do_token" {
  description = "API token for accessing DigitalOcean"
  type        = string
  sensitive   = true
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

# Create a web server
resource "digitalocean_droplet" "main" {
  name       = "ubuntu-s-1vcpu-1gb-fra1-01"
  region     = "fra1"
  tags       = ["critical"]
  size       = "s-1vcpu-2gb"
  image      = "69463186"
  monitoring = true
}

resource "digitalocean_floating_ip" "randovania_metroidprime_run" {
  droplet_id = digitalocean_droplet.main.id
  region     = "fra1"
}

resource "digitalocean_droplet" "staging" {
  name       = "staging-fra1-01"
  region     = "fra1"
  tags       = ["critical"]
  size       = "s-1vcpu-1gb"
  image      = "docker-20-04"
  monitoring = true
  ssh_keys   = ["37:df:56:8b:b6:e1:d8:eb:23:93:f4:14:8c:98:1c:43"]
}
