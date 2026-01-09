# PRACTICE: Create a Map of Users using zipmap
# Uncomment to test!

# variable "user_names" {
#   type    = list(string)
#   default = ["alice", "bob"]
# }

# variable "roles" {
#   type    = list(string)
#   default = ["admin", "editor"]
# }

# # zipmap() combines two lists into a map: key list + value list
# output "user_roles_map" {
#   value = zipmap(var.user_names, var.roles)
# }
