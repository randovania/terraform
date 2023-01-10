terraform {
  backend "remote" {
    organization = "randovania"

    workspaces {
      name = "server"
    }
  }

  required_version = ">= 0.14.0"
}