# PRACTICE: Simplify this Resource!
# Below is a resource with MESSY configuration. 
# Your goal: Create a local for the tags and the bucket name to make it clean.

# variable "dept" { default = "sales" }
# variable "region_short" { default = "use1" }

# resource "aws_s3_bucket" "messy_bucket" {
#   # CHALLENGE: Create a local `bucket_name` = "my-company-${var.dept}-${var.region_short}-data"
#   # and assign it here.
#   bucket = "my-company-${var.dept}-${var.region_short}-data"
#
#   # CHALLENGE: Create a local `bucket_tags` to hold this map
#   tags = {
#     CreatedBy   = "Terraform"
#     Department  = var.dept
#     Center      = "Cost-123"
#     Region      = var.region_short
#   }
# }
