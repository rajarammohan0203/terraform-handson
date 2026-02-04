resource "random_password" "secure" {
  length           = 16
  special          = true
  override_special = "!@#$%"
}
