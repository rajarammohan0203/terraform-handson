resource "aws_dynamodb_table" "this" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "PK"
  range_key    = "SK"

  attribute {
    name = "PK"
    type = "S"
  }

  attribute {
    name = "SK"
    type = "S"
  }

  tags = {
    Environment = "prod"
    ManagedBy   = "Terraform Module"
  }
}

# Emulating a "Bundle" by creating a related resource
# e.g. An SSM Parameter that stores the table name for apps to discover
resource "aws_ssm_parameter" "table_config" {
  name  = "/app/${var.table_name}/config"
  type  = "String"
  value = "active"
}
