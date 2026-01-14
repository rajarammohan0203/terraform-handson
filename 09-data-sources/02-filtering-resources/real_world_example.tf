# ---------------------------------------------------------------------------------------------------------------------
# DATA SOURCES: FILTERING & SEARCHING
# ---------------------------------------------------------------------------------------------------------------------
# Often you need to use resources that ALREADY exist but you don't know their IDs.
# Data Sources allow you to FILTER/SEARCH for them.

# ---------------------------------------------------------------------------------------------------------------------
# 1. FIND THE LATEST AMI (Amazon Machine Image)
# ---------------------------------------------------------------------------------------------------------------------
# Scenario: You want to launch an Ubuntu instance, but the AMI ID changes every week.
# Solution: Search for the latest image owned by Canonical (Ubuntu creators).

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical's AWS Account ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# 2. FIND AN EXISTING VPC
# ---------------------------------------------------------------------------------------------------------------------
# Scenario: You need to launch into the "Default" VPC, but you don't want to hardcode "vpc-12345".
# Solution: Search for a VPC that has the tag Name="Default" (or is_default=true).

data "aws_vpc" "selected" {
  default = true # In LocalStack/AWS, this finds the default VPC
}

# ---------------------------------------------------------------------------------------------------------------------
# USE THEM TO CREATE A RESOURCE
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_instance" "web" {
  # USE THE FOUND AMI
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  # USE THE FOUND VPC (Indirectly via Subnet - simplifed here to just use ID)
  # Note: Usually we'd find a subnet inside that VPC.

  tags = {
    Name = var.instance_name
    Info = "Launched using AMI: ${data.aws_ami.ubuntu.name}"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# OUTPUTS
# ---------------------------------------------------------------------------------------------------------------------

output "ami_details" {
  value = {
    id   = data.aws_ami.ubuntu.id
    name = data.aws_ami.ubuntu.name
  }
}

output "vpc_details" {
  value = {
    id         = data.aws_vpc.selected.id
    cidr_block = data.aws_vpc.selected.cidr_block
  }
}
