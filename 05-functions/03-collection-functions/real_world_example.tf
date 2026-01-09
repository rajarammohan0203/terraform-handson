# ---------------------------------------------------------------------------------------------------------------------
# COLLECTION FUNCTIONS
# ---------------------------------------------------------------------------------------------------------------------
# Manipulate lists and maps.
# Common functions: length(), merge(), element(), keys(), sort()

# ---------------------------------------------------------------------------------------------------------------------
# EXAMPLE 1: MERGE (Tagging Strategies & Compliance)
# ---------------------------------------------------------------------------------------------------------------------
# SCENARIO: Your Security Team enforces mandatory tags ("Owner", "Environment") on ALL resources.
# Individual teams have their own project-specific tags ("CostCenter", "Project").
# You must combine them. If there's a conflict, the TEAM tag should win (or Security tag, depending on order).

locals {
  # Logic: merge(map1, map2)
  # If keys duplicate, the LAST map's value overrides the previous ones.
  # Here: var.project_tags overrides var.common_tags if there's a conflict.
  final_tags = merge(var.common_tags, var.project_tags)
}

resource "aws_s3_bucket" "tagged_bucket" {
  bucket = "my-compliance-tagged-bucket-12345"
  tags   = local.final_tags
}

output "compliance_tag_check" {
  value       = local.final_tags
  description = "Final set of tags applied to resources"
}

# ---------------------------------------------------------------------------------------------------------------------
# EXAMPLE 2: SORT & ELEMENT (Round Robin High Availability)
# ---------------------------------------------------------------------------------------------------------------------
# SCENARIO: You have 3 Subnets (AZ-a, AZ-b, AZ-c) but you are deploying 5 Instances.
# You want to distribute instances evenly: A, B, C, A, B.
# This ensures that if one AZ goes down, you only lose a portion of your fleet.

locals {
  # 1. Sort AZs to ensure predictable order (a, b, c) logic
  sorted_azs = sort(var.availability_zones)
}

# Simulating 5 instances
resource "aws_instance" "ha_cluster" {
  count = 5

  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  # element(list, index) WRAPS AROUND if index > length
  # index 0 -> AZ[0]
  # index 1 -> AZ[1]
  # index 2 -> AZ[2]
  # index 3 -> AZ[0] (Loop back to start!)
  availability_zone = element(local.sorted_azs, count.index)

  tags = {
    Name = "ha-instance-${count.index}"
    AZ   = element(local.sorted_azs, count.index)
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# EXAMPLE 3: KEYS & LENGTH (Validation & Dynamic Logic)
# ---------------------------------------------------------------------------------------------------------------------
# SCENARIO: You need to know which Tag Keys are present to pass to a monitoring system
# or simply to validate that "Owner" tag exists.

output "tag_keys_present" {
  value = keys(local.final_tags) # ["CostCenter", "Environment", "Owner", "Project"]
}

output "total_tags_applied" {
  value = length(local.final_tags)
}
