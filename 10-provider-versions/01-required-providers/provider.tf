terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      # "Pinning" the version
      # ~> 5.0 means: >= 5.0.0 and < 6.0.0
      # This allows bug fixes (5.1, 5.2) but prevents Breaking Changes (6.0)
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.0" # EXACT version match
    }
  }

  required_version = ">= 1.5.0" # Terraform CLI version constraint
}

provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    ec2 = "http://localhost:4566"
    sts = "http://localhost:4566"
  }
}
