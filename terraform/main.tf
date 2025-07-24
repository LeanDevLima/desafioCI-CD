variable "koyeb_token" {
  type = string
  sensitive = true
}

variable "image" {
  type = string
  description = "Docker image to deploy"
}

provider "koyeb" {
  token = var.koyeb_token
}

resource "koyeb_app" "saudacoes-app" {
  name = "saudacoes-app"
}

resource "koyeb_service" "saudacoes-service" {
  app_name = koyeb_app.saudacoes-app.name
  name = "saudacoes-service"
  
  definition {
    port = 8080
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