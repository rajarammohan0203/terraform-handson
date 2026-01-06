# ---------------------------------------------------------------------------------------------------------------------
# 1. ACCESSING LISTS BY INDEX
# ---------------------------------------------------------------------------------------------------------------------

# Create a VPC first
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "accessing-collections-vpc"
  }
}

# Access list items by index to create subnets
resource "aws_subnet" "first" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidrs[0] # Accessing index 0

  tags = {
    Name = "First Subnet"
  }
}

resource "aws_subnet" "second" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidrs[1] # Accessing index 1

  tags = {
    Name = "Second Subnet"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# 2. ACCESSING MAPS BY KEY
# ---------------------------------------------------------------------------------------------------------------------

# Access map values by key to create an EC2 instance
resource "aws_instance" "app_server" {
  ami           = var.ami_map["us-east-1"] # Accessing map by key
  instance_type = "t2.micro"

  # Access multiple map values for tags
  tags = {
    Name        = "AppServer"
    Environment = var.instance_tags["Environment"] # Accessing by key
    Project     = var.instance_tags["Project"]     # Accessing by key
    Owner       = var.instance_tags["Owner"]       # Accessing by key
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# 3. USING FOR EXPRESSIONS TO TRANSFORM DATA
# ---------------------------------------------------------------------------------------------------------------------

# Transform list: Add prefix to each CIDR
locals {
  subnet_names = [for idx, cidr in var.subnet_cidrs : "subnet-${idx}-${cidr}"]
}

# Transform map: Convert to uppercase values
locals {
  uppercase_tags = { for key, value in var.instance_tags : key => upper(value) }
}

# ---------------------------------------------------------------------------------------------------------------------
# OUTPUTS
# ---------------------------------------------------------------------------------------------------------------------

output "first_subnet_cidr" {
  value       = var.subnet_cidrs[0]
  description = "Accessing first item from list"
}

output "last_subnet_cidr" {
  value       = var.subnet_cidrs[length(var.subnet_cidrs) - 1]
  description = "Accessing last item from list using length()"
}

output "environment_tag" {
  value       = var.instance_tags["Environment"]
  description = "Accessing specific map value by key"
}

output "all_tag_keys" {
  value       = keys(var.instance_tags)
  description = "Getting all keys from a map"
}

output "all_tag_values" {
  value       = values(var.instance_tags)
  description = "Getting all values from a map"
}

output "transformed_subnet_names" {
  value       = local.subnet_names
  description = "List transformed using for expression"
}

output "transformed_tags" {
  value       = local.uppercase_tags
  description = "Map transformed using for expression"
}


