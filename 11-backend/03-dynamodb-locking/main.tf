resource "aws_dynamodb_table" "app_table" {
  name         = "ApplicationData"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "UserId"

  attribute {
    name = "UserId"
    type = "S"
  }
}

# Again, we are creating a resource (DynamoDB table) HERE.
# But the "Lock Table" used by the Backend MUST be created manually beforehand.
