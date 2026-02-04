terraform {
  required_version = ">= 1.10.0" # REQUIRED for this feature

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "my-terraform-state-bucket"
    key    = "native-lock/terraform.tfstate"
    region = "us-east-1"

    # NEW FEATURE (Aug 2024 / TF 1.10+)
    # This tells S3 to use its own "Conditional Writes" for locking.
    # NO DynamoDB table required!
    use_lockfile = true

    # LocalStack specific endpoint
    endpoint                    = "http://localhost:4566"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
    force_path_style            = true
  }
}

provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3 = "http://localhost:4566"
  }
}
