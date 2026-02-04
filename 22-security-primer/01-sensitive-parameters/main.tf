resource "local_file" "db_config" {
  filename = "${path.module}/config.conf"
  content  = "host=localhost\npassword=${var.db_password}"
}
