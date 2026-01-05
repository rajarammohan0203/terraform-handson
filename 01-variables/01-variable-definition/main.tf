# 1. Create a VPC using a variable
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  
  tags = {
    Name = "MyVariableVPC"
  }
}

# 2. Create a Subnet using a variable
resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr
  
  tags = {
    Name = "MyVariableSubnet"
  }
}

# 3. Create an Instance using variables
resource "aws_instance" "server" {
  ami           = "ami-12345678" # Hardcoded for now
  instance_type = var.instance_type
  subnet_id     = aws_subnet.subnet1.id

  tags = {
    Name = "Server-Running-${var.os_name}" # String interpolation
  }
}
