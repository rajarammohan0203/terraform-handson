# IAM User in Dev Account
resource "aws_iam_user" "dev_user" {
  provider = aws.dev_account
  name     = "developer-junior"
}

# IAM User in Prod Account
resource "aws_iam_user" "prod_user" {
  provider = aws.prod_account
  name     = "ops-admin"
}
