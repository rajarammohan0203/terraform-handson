# LIVE INFRASTRUCTURE
# This file represents the ACTUAL environment (Account: Dev, Region: us-east-1).

module "vpc" {
  # In real life, this points to a Git Tag:
  # source = "git::https://github.com/my-org/modules.git//vpc?ref=v1.0.0"

  source = "../../../../../modules/vpc"

  vpc_cidr = "10.0.0.0/16"
  env_name = "dev"
}
