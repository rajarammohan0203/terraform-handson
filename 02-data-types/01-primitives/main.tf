resource "aws_instance" "app_server" {
  # NUMBER: Using a number variable for count (loops)
  count = var.instance_count

  # STRING: Using a string variable for the AMI ID
  ami           = var.ami_id
  instance_type = "t2.micro"

  # BOOL: Using a boolean variable to toggle a feature
  associate_public_ip_address = var.enable_public_ip

  tags = {
    Name = "Practice-Instance-${count.index}"
  }
}

output "instance_ids" {
  value = aws_instance.app_server[*].id
}

output "public_ip_enabled" {
  value = var.enable_public_ip
}
