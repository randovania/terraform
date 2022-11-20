terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.24.0"
    }
  }
}

# Set the variable value in *.tfvars file
# or using -var="do_token=..." CLI option
variable "do_token" {}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

# Create a web server
resource "digitalocean_droplet" "main" {
  name   = "ubuntu-s-1vcpu-1gb-fra1-01"
  region = "fra1"
  tags   = ["critical"]
  size   = "s-1vcpu-2gb"
  image  = "69463186"
  monitoring = true
}

resource "digitalocean_floating_ip" "randovania_metroidprime_run" {
  droplet_id = digitalocean_droplet.main.id
  region = "fra1"
}
