# ---------------------------------------------------------------------------------------------------------------------
# LIST EXAMPLE: Subnet CIDR Blocks
# ---------------------------------------------------------------------------------------------------------------------
# We'll access specific items by index: [0], [1], [2]

variable "subnet_cidrs" {
  type = list(string)
  default = [
    "10.0.1.0/24", # Index 0 - First subnet
    "10.0.2.0/24", # Index 1 - Second subnet
    "10.0.3.0/24"  # Index 2 - Third subnet
  ]
  description = "List of CIDR blocks for subnets. Access by index."
}

# ---------------------------------------------------------------------------------------------------------------------
# MAP EXAMPLE: Instance Tags
# ---------------------------------------------------------------------------------------------------------------------
# We'll access specific values by key: ["Environment"], ["Project"], etc.

variable "instance_tags" {
  type = map(string)
  default = {
    Environment = "Development"
    Project     = "TerraformLearning"
    Owner       = "DevOps Team"
    CostCenter  = "Engineering"
  }
  description = "Map of tags for EC2 instances. Access by key."
}

# ---------------------------------------------------------------------------------------------------------------------
# MAP EXAMPLE: Region-specific AMI IDs
# ---------------------------------------------------------------------------------------------------------------------
# Real-world use case: Different AMI IDs for different regions

variable "ami_map" {
  type = map(string)
  default = {
    "us-east-1" = "ami-0c55b159cbfafe1f0"
    "us-west-2" = "ami-0d1cd67c26f5fca19"
    "eu-west-1" = "ami-0bbc25e23a7640b9b"
  }
  description = "Map of AMI IDs by region. Access by region key."
}
