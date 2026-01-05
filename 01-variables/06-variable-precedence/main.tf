# We use SSM Parameter Store to easily see the final value
resource "aws_ssm_parameter" "color" {
  name  = "/precedence/test/color"
  type  = "String"
  value = var.favorite_color
}

output "final_value" {
  value = var.favorite_color
}
