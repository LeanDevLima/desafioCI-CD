terraform {
  required_providers {
    koyeb = {
      source  = "koyeb/koyeb"
      version = "2.1.0"
    }
  }
}

variable "koyeb_token" {
  type      = string
  sensitive = true
}

variable "image" {
  type = string
}

provider "koyeb" {
  token = var.koyeb_token
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
