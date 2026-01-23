terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      # We DECLARE that this module needs 2 AWS providers.
      # The user MUST pass them in.
      configuration_aliases = [aws.src, aws.dst]
    }
  }
}

resource "aws_s3_bucket" "primary" {
  provider = aws.src # Uses the first provider
  bucket   = "primary-bucket-us-east-1"
}

resource "aws_s3_bucket" "replica" {
  provider = aws.dst # Uses the second provider
  bucket   = "replica-bucket-us-west-2"
}
