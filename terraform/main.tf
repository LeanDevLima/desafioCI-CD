terraform {
  required_providers {
    koyeb = {
      source = "koyeb/koyeb"
      version = ">= 2.1.0, < 3.0.0"  # Intervalo de versões aceitáveis
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
  description = "Docker image to deploy (format: repository:tag)"
}

provider "koyeb" {
  # Configuração do token via variável
  token = var.koyeb_token
}

resource "koyeb_app" "saudacoes-app" {
  name = "saudacoes-app-${replace(substr(uuid(), 0, 8), "-", "")}"  # Nome único sem hifens
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