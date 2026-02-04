# Practice!
# 1. Setup the bucket and table commands from README.
# 2. Run terraform init.
# 3. Check the DynamoDB table items:
#    aws --endpoint-url=http://localhost:4566 dynamodb scan --table-name terraform-lock-table
#    (You might see a digest item if a lock was held or stuck).
