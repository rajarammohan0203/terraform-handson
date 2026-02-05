# ---------------------------------------------------------------------------------------------------------------------
# FILE: network.tf
# ---------------------------------------------------------------------------------------------------------------------
# Even though this is in a separate file, other files can reference "aws_vpc.main.id"
# just as if they were in the same file.

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "${var.app_name}-vpc"
    File = "network.tf"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "${var.app_name}-subnet"
  }
}
