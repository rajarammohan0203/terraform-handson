resource "aws_vpc" "shared_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Shared-VPC"
  }
}

resource "aws_subnet" "subnet_a" {
  vpc_id     = aws_vpc.shared_vpc.id
  cidr_block = "10.0.1.0/24"
}
