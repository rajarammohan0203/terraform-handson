# ---------------------------------------------------------------------------------------------------------------------
# MODULE SOURCES: WHERE DOES THE CODE LIVE?
# ---------------------------------------------------------------------------------------------------------------------

# 1. LOCAL PATH (What we used before)
# Best for: Monorepos, tightly coupled code.
module "local_bucket" {
  source = "../01-module-basics/modules/s3_storage"

  bucket_name = "my-local-source-bucket-001"
  environment = "dev"
}

# 2. TERRAFORM REGISTRY (Public)
# Best for: Community standard modules (VPC, EKS).
# Docs: registry.terraform.io
# NOTE: This won't work in LocalStack without internet/valid creds usually, 
# but this is how you write it.
/*
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "my-vpc"
  cidr = "10.0.0.0/16"
}
*/

# 3. GITHUB / BITBUCKET (Private or Public)
# Best for: Shared Private Modules across the company.
# Syntax: "git::https://github.com/ORG/REPO.git?ref=VERSION"
# The "?ref=v1.0.0" is CRITICAL for stability (Pinning versions).
/*
module "private_module" {
  source = "git::https://github.com/my-org/terraform-modules.git//modules/s3?ref=v1.2.0"
  
  bucket_name = "git-sourced-bucket"
}
*/

# 4. S3 BUCKET (Zip file)
# Best for: Very strict security environments (Air-gapped).
# source = "s3::https://s3-eu-west-1.amazonaws.com/mybucket/modules.zip"
