output "dev_user_arn" {
  value = aws_iam_user.dev_user.arn
}

output "prod_user_arn" {
  value = aws_iam_user.prod_user.arn
}
