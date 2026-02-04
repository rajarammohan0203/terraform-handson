# Resource in Default Region (us-east-1)
resource "aws_s3_bucket" "us_bucket" {
  bucket = "my-app-data-us-east-1"
  # No provider argument needed; uses default
}

# Resource in Europe Region (eu-west-1)
resource "aws_s3_bucket" "eu_bucket" {
  provider = aws.europe # Reference the alias!

  bucket = "my-app-data-eu-west-1"
}
