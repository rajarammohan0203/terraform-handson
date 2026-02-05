resource "random_password" "db_password" {
  length  = 16
  special = true
}

resource "aws_ssm_parameter" "secret" {
  name  = "/prod/db/password"
  type  = "SecureString"
  value = random_password.db_password.result
}
