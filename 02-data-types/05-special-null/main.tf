resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "null-demo-vpc"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  # NULL USAGE:
  # If var.availability_zone is "us-east-1a", Terraform forces that AZ.
  # If var.availability_zone is NULL, Terraform omits this argument, letting AWS choose.
  availability_zone = var.availability_zone
}

output "subnet_az" {
  value = aws_subnet.main.availability_zone
}
