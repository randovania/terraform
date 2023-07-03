

resource "digitalocean_firewall" "http_server" {
  name = "http-server"

  droplet_ids = [
    digitalocean_droplet.production.id,
  ]


  # Allow SSH and Pinging from anywhere
  inbound_rule {
    protocol         = "icmp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # Everything inside VPC
  inbound_rule {
    protocol         = "tcp"
    port_range       = "all"
    source_addresses = ["10.114.0.0/20"]
  }
  inbound_rule {
    protocol         = "udp"
    port_range       = "all"
    source_addresses = ["10.114.0.0/20"]
  }

  # Allow all traffic out
  outbound_rule {
    protocol              = "tcp"
    port_range            = "all"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "all"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  # Allow HTTP/HTTPS/RabbitMQ traffic
  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "2377"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # # Allow direct access to portainer, for debugging
  # inbound_rule {
  #   protocol         = "tcp"
  #   port_range       = "8000"
  #   source_addresses = ["0.0.0.0/0", "::/0"]
  # }
}

resource "digitalocean_firewall" "swarm_member" {
  name = "swarm-member"

  droplet_ids = [digitalocean_droplet.staging.id]

  # Allow SSH and Pinging from anywhere
  inbound_rule {
    protocol         = "icmp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # Everything inside VPC
  inbound_rule {
    protocol         = "tcp"
    port_range       = "all"
    source_addresses = ["10.114.0.0/20"]
  }
  inbound_rule {
    protocol         = "udp"
    port_range       = "all"
    source_addresses = ["10.114.0.0/20"]
  }

  # Allow all traffic out
  outbound_rule {
    protocol              = "tcp"
    port_range            = "all"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "all"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}
