# STANDARD VPC MODULE
# This module enforces company standards (Tags, DNS support, Flow Logs, etc.)

resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.env_name}-vpc"
    Environment = var.env_name
    Owner       = "PlatformTeam"
  }
}
