# Practice!
# 1. Create a DynamoDB table manually:
#    aws --endpoint-url=http://localhost:4566 dynamodb create-table --table-name old-table --attribute-definitions AttributeName=ID,AttributeType=S --key-schema AttributeName=ID,KeyType=HASH --billing-mode PAY_PER_REQUEST
# 2. Add an empty `resource "aws_dynamodb_table" "old" {}` block here (terraform usually needs minimal config).
# 3. Run `terraform import aws_dynamodb_table.old old-table`.
