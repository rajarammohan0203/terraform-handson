# 04-removed-blocks/main.tf

# PHASE 1: Create the resource
# Uncomment this, init, and apply.
resource "random_pet" "database" {
  length = 2
}

# PHASE 2: "Remove" it Declaratively
# 1. Comment out the resource block above.
# 2. Uncomment the 'removed' block below.
# 3. Run 'terraform apply'.

/*
removed {
  from = random_pet.database

  lifecycle {
    destroy = false # <--- The Magic. Keeps it alive in cloud, removes from TF.
  }
}
*/
