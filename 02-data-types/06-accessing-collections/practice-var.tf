# ---------------------------------------------------------------------------------------------------------------------
# PRACTICE EXERCISES
# ---------------------------------------------------------------------------------------------------------------------

# 1. LIST ACCESS EXERCISE
# Create a variable "availability_zones" of type list(string).
# Default: ["us-east-1a", "us-east-1b", "us-east-1c"]

# variable "availability_zones" {
#   type    = list(string)
#   default = ["us-east-1a", "us-east-1b", "us-east-1c"]
# }

# 2. ACCESS SPECIFIC ZONE
# Create an output that accesses the SECOND availability zone (index 1)

# output "second_zone" {
#   value = var.availability_zones[1]
# }

# 3. MAP ACCESS EXERCISE
# Create a variable "port_map" of type map(number).
# Default: { http = 80, https = 443, ssh = 22 }

# variable "port_map" {
#   type = map(number)
#   default = {
#     http  = 80
#     https = 443
#     ssh   = 22
#   }
# }

# 4. ACCESS SPECIFIC PORT
# Create an output that accesses the HTTPS port

# output "https_port" {
#   value = var.port_map["https"]
# }

# 5. ADVANCED: FOR EXPRESSION
# Create an output that transforms the port_map to show "Protocol: Port" format
# Example: ["http: 80", "https: 443", "ssh: 22"]

# output "port_descriptions" {
#   value = [for protocol, port in var.port_map : "${protocol}: ${port}"]
# }
