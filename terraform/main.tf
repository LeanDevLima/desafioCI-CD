terraform {
  required_providers {
    koyeb = {
      source  = "koyeb/koyeb"
      version = "0.1.11"
    }
  }
}

provider "koyeb" {}

variable "image" {
  type = string
}

resource "koyeb_app" "app" {
  name = "saudacoes-app"
}

resource "koyeb_service" "service" {
  app_name = koyeb_app.app.name

  definition {
    name    = "saudacoes-def"
    regions = ["fra"]

    instance_types {
      type = "micro"
    }

    scalings {
      min = 1
      max = 1
    }

    routes {
      path = "/"
      port = 8080
    }

    docker {
      image = var.image
    }
  }
}
