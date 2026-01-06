# PRACTICE: Create multiple IAM users and get all their names
# Uncomment to test:

# variable "user_count" {
#   type    = number
#   default = 3
# }

# resource "aws_iam_user" "developers" {
#   count = var.user_count
#   name  = "developer-${count.index}"
# }

# output "all_user_names" {
#   value = aws_iam_user.developers[*].name
# }

# output "total_users" {
#   value = length(aws_iam_user.developers[*].name)
# }
