resource "aws_instance" "my_first_server" {
  ami           = "ami-12345678" # In LocalStack, this can be any string
  instance_type = "t2.micro"

  tags = {
    Name = "MyFirstLocalInstance"
    Env  = "Dev"
  }
}
