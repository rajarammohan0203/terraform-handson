provider "aws" {
  region = "us-east-1"
  # LocalStack Configuration
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    # Using LocalStack for the "Real Time Example" simulation
    rds = "http://localhost:4566"
  }
}
