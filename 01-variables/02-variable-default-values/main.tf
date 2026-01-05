# 1. VPC using the default CIDR (10.50.0.0/16)
resource "aws_vpc" "default_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "VPC-${var.environment_tag}"
  }
}

# 2. Instance using defaults
resource "aws_instance" "app" {
  ami           = "ami-12345678"
  instance_type = var.instance_type
  monitoring    = var.enable_monitoring

  tags = {
    Name = "App-Server-${var.environment_tag}"
  }
}

# 3. Output to prove which values were used
output "vpc_cidr_used" {
  value = aws_vpc.default_vpc.cidr_block
}

output "instance_type_used" {
  value = aws_instance.app.instance_type
}
