resource "random_id" "server_id" {
  byte_length = 8
}

resource "aws_instance" "web_server" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"

  tags = {
    Name = "WebServer-${random_id.server_id.hex}"
  }
}
