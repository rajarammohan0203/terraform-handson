# PRACTICE CHALLENGE
# Uncomment to run.

# SCENARIO: 
# You have a resource "aws_iam_role" and "aws_iam_role_policy_attachment".
# You have an "aws_lambda_function" that uses that role.
# Sometimes (rarely), the Lambda fails because the Role is created but the Policy hasn't propagated yet.
# How do you ensure the Policy attachment is fully complete before Lambda creation?

# resource "aws_iam_role" "lambda_role" { ... }
# resource "aws_iam_role_policy_attachment" "attach" { ... }

# resource "aws_lambda_function" "func" {
#   role = aws_iam_role.lambda_role.arn
#   
#   # CHALLENGE: Add the fix below
#   # depends_on = [aws_iam_role_policy_attachment.attach]
# }
