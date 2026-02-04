# We use 'random_pet' because it's easy to create many of them.

resource "random_pet" "server_names" {
  count  = 3
  length = 2
}

resource "random_pet" "user_roles" {
  for_each = toset(["admin", "editor", "viewer"])
  length   = 1
  prefix   = each.key
}

# Nested module to show how state list looks with modules
module "vpc" {
  source = "./modules/vpc"
}
