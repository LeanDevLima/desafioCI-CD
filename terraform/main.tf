terraform {
  required_providers {
    koyeb = {
      source = "koyeb/koyeb"
      version = "~> 2.1.0"  # Usando versão mais recente da série 2.1.x
    }
  }
}

variable "koyeb_token" {
  type        = string
  sensitive   = true
  description = "Koyeb API token"
}

variable "image" {
  type        = string
  description = "Docker image to deploy"
}

provider "koyeb" {
  token = var.koyeb_token
}

resource "koyeb_app" "saudacoes-app" {
  name = "saudacoes-app-${substr(uuid(), 0, 8)}"  # Nome único para cada deploy
}

resource "koyeb_service" "saudacoes-service" {
  app_name = koyeb_app.saudacoes-app.name
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

output "service_url" {
  value = "https://${koyeb_app.saudacoes-app.name}.koyeb.app"
}