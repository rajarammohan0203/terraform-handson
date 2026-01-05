# ---------------------------------------------------------
# LocalStack Provider Override
# Copy this file to your project folder to use LocalStack.
# ---------------------------------------------------------

provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  
  # Skip validations that fail on LocalStack
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  # Point commonly used services to LocalStack
  endpoints {
    ec2            = "http://localhost:4566"
    s3             = "http://localhost:4566"
    iam            = "http://localhost:4566"
    sts            = "http://localhost:4566"
    lambda         = "http://localhost:4566"
    dynamodb       = "http://localhost:4566"
    cloudwatch     = "http://localhost:4566"
    route53        = "http://localhost:4566"
    secretsmanager = "http://localhost:4566"
    sns            = "http://localhost:4566"
    sqs            = "http://localhost:4566"
    rds            = "http://localhost:4566"
    ssm            = "http://localhost:4566"
  }
}
