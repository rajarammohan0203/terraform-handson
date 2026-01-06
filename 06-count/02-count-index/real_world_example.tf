# ---------------------------------------------------------------------------------------------------------------------
# WHAT IS count.index?
# ---------------------------------------------------------------------------------------------------------------------
# count.index is a special variable that gives you the current iteration number (starting from 0)
# 
# Example:
# count = 3
# - First resource: count.index = 0
# - Second resource: count.index = 1
# - Third resource: count.index = 2

# ---------------------------------------------------------------------------------------------------------------------
# EXAMPLE 1: Using count.index for Naming
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_s3_bucket" "logs" {
  count  = 3
  bucket = "app-logs-${count.index}" # Creates: app-logs-0, app-logs-1, app-logs-2
}

# ---------------------------------------------------------------------------------------------------------------------
# EXAMPLE 2: Using count.index to Access List Items
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "count-index-demo-vpc"
  }
}

resource "aws_subnet" "subnets" {
  count = var.subnet_count

  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidrs[count.index] # Uses count.index to access list items

  tags = {
    Name = "subnet-${count.index}"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# EXAMPLE 3: Using count.index in Calculations
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_iam_user" "team" {
  count = 5
  name  = "team-member-${count.index + 1}" # Starts from 1 instead of 0
}

# ---------------------------------------------------------------------------------------------------------------------
# OUTPUTS
# ---------------------------------------------------------------------------------------------------------------------

output "bucket_names" {
  value       = aws_s3_bucket.logs[*].bucket
  description = "All bucket names created with count.index"
}

output "subnet_cidrs_created" {
  value       = aws_subnet.subnets[*].cidr_block
  description = "All subnet CIDRs (accessed via count.index)"
}

output "team_members" {
  value       = aws_iam_user.team[*].name
  description = "Team member names (count.index + 1)"
}
