terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# The "Dev" Account Provider
provider "aws" {
  alias  = "dev_account"
  region = "us-east-1"

  # In Real Life: You would use `profile = "dev-profile"`
  # For LocalStack: We verify it's different by using a different access key (conceptually)
  access_key = "dev-key"
  secret_key = "dev-secret"

  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    iam = "http://localhost:4566"
    sts = "http://localhost:4566"
  }
}

# The "Prod" Account Provider
provider "aws" {
  alias  = "prod_account"
  region = "us-east-1"

  # In Real Life: You would use `profile = "prod-profile"`
  access_key = "prod-key"
  secret_key = "prod-secret"

  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    iam = "http://localhost:4566"
    sts = "http://localhost:4566"
  }
}
