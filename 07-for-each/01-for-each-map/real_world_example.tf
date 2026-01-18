# ---------------------------------------------------------------------------------------------------------------------
# FOR_EACH: ITERATING OVER MAPS
# ---------------------------------------------------------------------------------------------------------------------
# SCENARIO:
# We need to create multiple IAM Users.
# BUT, each user is unique! Alice is an Admin, Bob is in Marketing.
# "count" cannot handle this easily (it just gives you index 0, 1, 2).
# "for_each" gives you the KEY ("alice") and the VALUE ({dept="eng", admin=true}).

resource "aws_iam_user" "users" {
  # iterating over the map "var.users_map"
  for_each = var.users_map

  # each.key   = "alice"
  # each.value = { department = "engineering", is_admin = true }

  name = each.key

  tags = {
    Department = each.value.department
    Role       = each.value.is_admin ? "Admin" : "StandardUser"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# OUTPUTS
# ---------------------------------------------------------------------------------------------------------------------
# When using for_each, the output is a MAP of resources, not a List.

output "all_user_arns" {
  value = [for user in aws_iam_user.users : user.arn]
}
