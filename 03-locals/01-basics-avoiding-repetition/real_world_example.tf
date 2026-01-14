# ---------------------------------------------------------------------------------------------------------------------
# LOCALS: AVOIDING REPETITION (DRY Principle)
# ---------------------------------------------------------------------------------------------------------------------
# Locals allow you to define a value ONCE and reuse it many times.
# If you need to change it, you only change it in one place!

locals {
  # 1. Standardized Naming Convention
  # We define this ONCE. All resources will use this prefix.
  name_prefix = "${var.project_name}-${var.environment}"

  # 2. Common Tags
  # Every resource in this stack needs these tags. We define them ONCE.
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Owner       = "MarketingTeam"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# RESOURCES USING LOCALS
# ---------------------------------------------------------------------------------------------------------------------

# Resource 1: S3 Bucket
resource "aws_s3_bucket" "assets" {
  # usage: local.NAME
  bucket = "${local.name_prefix}-assets"

  tags = local.common_tags
}

# Resource 2: S3 Bucket for Logs
resource "aws_s3_bucket" "logs" {
  bucket = "${local.name_prefix}-logs"

  tags = local.common_tags
}

# Resource 3: EC2 Instance
resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-web-server"
    Role = "WebServer"
  })
}

# ---------------------------------------------------------------------------------------------------------------------
# PROOF IT WORKS
# ---------------------------------------------------------------------------------------------------------------------
output "bucket_names" {
  value = [
    aws_s3_bucket.assets.bucket,
    aws_s3_bucket.logs.bucket
  ]
}

output "tags_applied" {
  value = aws_instance.web.tags
}
