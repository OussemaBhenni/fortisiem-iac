terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

resource "docker_image" "kali" {
  name = "fortisiem-kali:latest"
  build {
    context    = "${path.module}/docker"
    dockerfile = "Dockerfile"
  }
  keep_locally = true
  triggers = {
    dockerfile_sha1 = sha1(file("${path.module}/docker/Dockerfile"))
  }
}

resource "docker_container" "kali" {
  name    = "kali-attacker"
  image   = docker_image.kali.image_id
  command = ["sleep", "infinity"]

  networks_advanced {
    name = var.network_name
  }
}

variable "network_name" {
  type = string
}

output "container_name" {
  value = docker_container.kali.name
}
