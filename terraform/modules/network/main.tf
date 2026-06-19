# Réseau Docker isolé pour FortiSIEM + Kali
# Aucune machine de prod Teamwill ne doit être joignable depuis ce réseau.

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

resource "docker_network" "fortisiem_net" {
  name = var.network_name

  ipam_config {
    subnet = "172.28.0.0/24"
  }
}

variable "network_name" {
  type = string
}

output "network_name" {
  value = docker_network.fortisiem_net.name
}
