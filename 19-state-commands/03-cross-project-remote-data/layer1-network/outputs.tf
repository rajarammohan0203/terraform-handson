output "vpc_id" {
  value = aws_vpc.shared_vpc.id
}

output "subnet_id" {
  value = aws_subnet.subnet_a.id
}
