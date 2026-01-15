# ---------------------------------------------------------------------------------------------------------------------
# MAP FUNCTIONS: LOOKUP, MERGE, ZIPMAP
# ---------------------------------------------------------------------------------------------------------------------

locals {
  # ---------------------------------------------------------------------------------------------------------------------
  # 1. LOOKUP (Safe Value Retrieval)
  # ---------------------------------------------------------------------------------------------------------------------
  # Scenario: You have a map of instance sizes per environment.
  # What if the user asks for "staging" but it's not in the map?
  # - var.instance_size["staging"] -> ERROR!
  # - lookup(var.instance_size, "staging", "t2.nano") -> SAFE! (Returns Default "t2.nano")

  selected_instance_type = lookup(var.instance_size, var.env, "t2.nano")

  # ---------------------------------------------------------------------------------------------------------------------
  # 2. MERGE (Combining Maps)
  # ---------------------------------------------------------------------------------------------------------------------
  # Scenario: You have "Company Wide Tags" and "Project Specific Tags".
  # You need to apply BOTH to your resources.

  final_tags = merge(var.common_tags, var.extra_tags, {
    Name = "My-Merged-Resource"
  })

  # ---------------------------------------------------------------------------------------------------------------------
  # 3. ZIPMAP (Lists -> Map)
  # ---------------------------------------------------------------------------------------------------------------------
  # Scenario: You created 3 IAM users and have 3 Access Keys.
  # Terraform gives you a List of Names and a List of Keys.
  # You want a SINGLE MAP: { "user1" = "key1", "user2" = "key2" }

  user_names = ["alice", "bob", "charlie"]
  user_keys  = ["key_for_alice", "key_for_bob", "key_for_charlie"]

  # Result: { "alice" = "key_for_alice", ... }
  user_credentials_map = zipmap(local.user_names, local.user_keys)
}

# ---------------------------------------------------------------------------------------------------------------------
# USAGE IN RESOURCES
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_instance" "app" {
  ami = "ami-0c55b159cbfafe1f0"

  # Uses the safely looked-up value
  instance_type = local.selected_instance_type

  # Uses the combined tags
  tags = local.final_tags
}

# ---------------------------------------------------------------------------------------------------------------------
# OUTPUTS
# ---------------------------------------------------------------------------------------------------------------------

output "lookup_result" {
  value       = local.selected_instance_type
  description = "Shows the instance type chosen (fallback used if key missing)"
}

output "zipmap_result" {
  value       = local.user_credentials_map
  description = "Shows the two lists combined into one map"
}
