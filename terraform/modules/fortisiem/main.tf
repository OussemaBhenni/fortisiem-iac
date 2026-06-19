# Conteneurs FortiSIEM (Supervisor / Worker / Collector)
#
# BLOQUANT : ce module ne peut pas être complété tant que le tuteur n'a pas fourni
# - l'image Docker (ou les instructions d'installation) FortiSIEM
# - la licence associée
#
# Ports à exposer une fois l'image connue :
#   443 -> GUI / API REST | 514 -> Syslog | 5480 -> Administration | 19999 -> Collector -> Supervisor

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

variable "network_name" {
  type = string
}

variable "fortisiem_image" {
  type    = string
  default = ""
}

# resource "docker_container" "fortisiem_supervisor" {
#   name  = "fortisiem-supervisor"
#   image = var.fortisiem_image
#   networks_advanced {
#     name = var.network_name
#   }
#   ports { internal = 443  external = 443 }
#   ports { internal = 514  external = 514 }
#   ports { internal = 5480 external = 5480 }
# }
