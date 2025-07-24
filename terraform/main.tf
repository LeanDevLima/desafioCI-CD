terraform {
  required_providers {
    koyeb = {
      source  = "koyeb/koyeb"
      version = "0.1.11"
    }
  }
}

variable "image" {
  type = string
}

provider "koyeb" {
  # A autenticação é feita via variável de ambiente KOYEB_TOKEN
}

resource "koyeb_app" "app" {
  name = "saudacoes-app"
}

resource "koyeb_service" "service" {
  app_name = koyeb_app.app.name
  name     = "saudacoes-service"

  definition {
    port   = 8080
    routes = ["/saudacao"]

    scaling {
      min = 1
      max = 1
    }

    docker {
      image = var.image
    }
  }
}

output "url" {
  value = "https://${koyeb_app.app.name}.koyeb.app"
}
