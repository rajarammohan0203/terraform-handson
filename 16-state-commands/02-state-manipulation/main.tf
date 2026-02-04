# INITIAL STATE
resource "random_pet" "database" {
  length = 2
}

# GOAL: Rename this to 'random_pet.production_db'
# WITHOUT destroying the existing one.
