# PRACTICE: Conditionally create a database instance
# Uncomment to test:

# variable "create_database" {
#   type    = bool
#   default = false
# }

# resource "aws_instance" "database" {
#   count = var.create_database ? 1 : 0
#   
#   ami           = "ami-0c55b159cbfafe1f0"
#   instance_type = "t2.micro"
#   
#   tags = {
#     Name = "database-server"
#   }
# }

# output "database_status" {
#   value = var.create_database ? "Database created" : "No database"
# }
