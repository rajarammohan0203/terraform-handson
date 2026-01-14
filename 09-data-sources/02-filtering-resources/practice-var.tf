# PRACTICE QUIZ
# Uncomment the code below to solve the challenge.

# ---------------------------------------------------------------------------------------------------------------------
# Challenge: Find a Subnet in the Default VPC
# ---------------------------------------------------------------------------------------------------------------------
# We found the VPC above (`data.aws_vpc.selected`).
# Now, try to find the "default" subnet within that VPC.

# data "aws_subnet" "default_subnet" {
#   vpc_id            = data.aws_vpc.selected.id
#   default_for_az    = true
#   availability_zone = "us-east-1a"
# }

# output "found_subnet_id" {
#   value = data.aws_subnet.default_subnet.id
# }
