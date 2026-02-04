resource "random_id" "server_id" {
  byte_length = 8
}

resource "local_file" "state_info" {
  content  = "The ID is ${random_id.server_id.hex}"
  filename = "${path.module}/server_id.txt"
}
