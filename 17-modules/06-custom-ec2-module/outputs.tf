output "vpc_id" {
  description = "The ID of the created VPC"
  value       = module.networking.vpc_id
}

output "web_server_public_ip" {
  description = "Public IP of the web server"
  value       = module.compute.public_ip
}

output "ssh_command" {
  description = "Command to SSH into the instance"
  value       = "ssh ec2-user@${module.compute.public_ip}"
}
