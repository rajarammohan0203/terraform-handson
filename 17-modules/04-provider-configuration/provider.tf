provider "aws" {
  alias  = "primary"
  region = "us-east-1"

  # LocalStack config
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  endpoints { s3 = "http://localhost:4566" }
}

provider "aws" {
  alias  = "secondary"
  region = "us-west-2"

  # LocalStack config
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  endpoints { s3 = "http://localhost:4566" }
}
