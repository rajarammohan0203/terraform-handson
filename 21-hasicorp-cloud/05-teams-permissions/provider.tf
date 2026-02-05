terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.50.0"
    }
  }
}

# To use this provider, you must set TFE_TOKEN environment variable
provider "tfe" {
  # hostname = "app.terraform.io" # defaults to SaaS
}
