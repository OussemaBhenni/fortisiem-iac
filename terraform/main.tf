# Point d'entrée Terraform — provisioning de l'infra locale (Docker)
#
# Statut : déploiement 100% local pour le moment.
# Le provider passera de kreuzwerker/docker à hashicorp/azurerm
# une fois la migration cloud confirmée par le tuteur (voir docs/architecture.md).

terraform {
  required_version = ">= 1.5"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

module "network" {
  source = "./modules/network"

  network_name = var.network_name
}

module "fortisiem" {
  source = "./modules/fortisiem"

  network_name = module.network.network_name

  # TODO : compléter une fois l'image/licence FortiSIEM récupérée auprès du tuteur
  # fortisiem_image = "..."
}

module "kali" {
  source = "./modules/kali"

  network_name = module.network.network_name
}
