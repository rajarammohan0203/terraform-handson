resource "aws_security_group" "web_server" {
  name        = "web-server-sg"
  description = "Allow inbound traffic on specific ports"
  vpc_id      = "vpc-12345678" # Placeholder for LocalStack

  # DYNAMIC BLOCK: Ingress
  # Instead of writing 'ingress {}' 5 times, we write it once.

  dynamic "ingress" {
    for_each = var.ingress_ports_list

    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  # Standard Egress (Allow all outbound)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
