# ---------------------------------------------------------------------------------------------------------------------
# STRING FUNCTIONS
# ---------------------------------------------------------------------------------------------------------------------
# Used to manipulate text. Very important for naming conventions and standardizing inputs.
# Common functions: tolower(), toupper(), replace(), split(), concat()

locals {
  # ---------------------------------------------------------------------------------------------------------------------
  # EXAMPLE 1: TOLOWER (S3 Compliance)
  # ---------------------------------------------------------------------------------------------------------------------
  # SCENARIO: S3 bucket names MUST be lowercase. Users might pass "MyProject".
  # If we don't fix it, Terraform apply will FAIL.
  clean_bucket_name = tolower(var.project_name)

  # ---------------------------------------------------------------------------------------------------------------------
  # EXAMPLE 2: TOUPPER (Tagging Standards)
  # ---------------------------------------------------------------------------------------------------------------------
  # SCENARIO: Your company policy requires Environment tags to be UPPERCASE (e.g., "DEV", "PROD").
  # Even if user passes "dev", we auto-fix it to "DEV".
  env_tag = toupper(var.environment)

  # ---------------------------------------------------------------------------------------------------------------------
  # EXAMPLE 3: REPLACE (Sanitization)
  # ---------------------------------------------------------------------------------------------------------------------
  # SCENARIO: Resource names cannot contain spaces or special chars.
  # User input: "My Super Project" -> We convert to "my_super_project"
  sanitized_name = replace(local.clean_bucket_name, "-", "_")

  # ---------------------------------------------------------------------------------------------------------------------
  # EXAMPLE 4: SPLIT (Processing Input Lists)
  # ---------------------------------------------------------------------------------------------------------------------
  # SCENARIO: You receive a list of subnets as a single comma-separated string from an environment variable.
  # Input: "10.0.1.0/24,10.0.2.0/24"
  # Need: ["10.0.1.0/24", "10.0.2.0/24"] (List format for count/for_each)
  subnet_list = split(",", var.subnet_list_string)
}

resource "aws_s3_bucket" "example" {
  bucket = local.clean_bucket_name

  tags = {
    Environment = local.env_tag        # "DEV"
    Original    = var.project_name     # "My-Super-Project"
    Sanitized   = local.sanitized_name # "my_super_project"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# EXAMPLE 5: CONCAT (Merging Lists)
# ---------------------------------------------------------------------------------------------------------------------
# SCENARIO: You have a list of default subnets and a user provides extra subnets.
# You need to merge them into one master list to create resources.

output "combined_subnet_list" {
  value       = concat(local.subnet_list, ["10.0.99.0/24"])
  description = "Merged list of user subnets + management subnet"
}

output "debug_steps" {
  value = {
    original   = var.project_name
    lowercase  = local.clean_bucket_name
    uppercase  = local.env_tag
    split_list = local.subnet_list
  }
}
