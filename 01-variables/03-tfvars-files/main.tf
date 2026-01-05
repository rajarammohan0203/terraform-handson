resource "aws_vpc" "app_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name        = "${var.environment_name}-vpc"
    Environment = var.environment_name
  }
}

resource "aws_instance" "server" {
  count         = var.instance_count
  ami           = "ami-12345678"
  instance_type = var.instance_type

  tags = {
    Name        = "${var.environment_name}-server-${count.index + 1}"
    Logging     = var.enable_logging
    Type        = var.instance_type
  }
}
