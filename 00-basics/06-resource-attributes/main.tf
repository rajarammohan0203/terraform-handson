# 1. Create an Elastic IP
resource "aws_eip" "my_vip" {
  domain = "vpc"
}

# 2. Create a Security Group
resource "aws_security_group" "my_sg" {
  name = "attribute-demo-sg"
}

# 3. Create an Instance
resource "aws_instance" "app_server" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"
  
  # CROSS REFERENCE: Using the ID of the Security Group created above
  vpc_security_group_ids = [aws_security_group.my_sg.id]
}

# 4. Associate the IP with the Instance
resource "aws_eip_association" "eip_assoc" {
  # CROSS REFERENCE: Taking the ID of the Instance
  instance_id   = aws_instance.app_server.id
  
  # CROSS REFERENCE: Taking the ID of the Elastic IP
  allocation_id = aws_eip.my_vip.id
}

# 5. Output values (Reference Attributes)
output "public_ip" {
  description = "The public IP address of the Elastic IP"
  value       = aws_eip.my_vip.public_ip
}

output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.app_server.id
}

output "security_group_id" {
  description = "The ID of the Security Group"
  value       = aws_security_group.my_sg.id
}
