# ---------------------------------------------------------------------------------------------------------------------
# WHAT IS COUNT?
# ---------------------------------------------------------------------------------------------------------------------
# 'count' tells Terraform: "Create this resource N times"
# Instead of copy-pasting the same resource block 3 times, we use count = 3

# WITHOUT COUNT (repetitive):
# resource "aws_instance" "web1" { ami = "ami-123", instance_type = "t2.micro" }
# resource "aws_instance" "web2" { ami = "ami-123", instance_type = "t2.micro" }
# resource "aws_instance" "web3" { ami = "ami-123", instance_type = "t2.micro" }

# WITH COUNT (clean):
resource "aws_instance" "web_servers" {
  count = var.server_count # Creates 3 identical servers

  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    # OPTION 1: Numbered names (web-server-0, web-server-1, web-server-2)
    # Name = "web-server-${count.index}"

    # OPTION 2: Custom names from a list (dev-amer, dev-etl, dev-ameo)
    Name = var.server_names[count.index]
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# OUTPUTS
# ---------------------------------------------------------------------------------------------------------------------

output "all_server_ids" {
  value       = aws_instance.web_servers[*].id
  description = "List of all created server IDs"
}

output "all_server_names" {
  value       = aws_instance.web_servers[*].tags.Name
  description = "List of all server names (dev-amer, dev-etl, dev-ameo)"
}

output "first_server_id" {
  value       = aws_instance.web_servers[0].id
  description = "The first server (index 0)"
}

output "server_count_created" {
  value       = length(aws_instance.web_servers)
  description = "Total number of servers created"
}
