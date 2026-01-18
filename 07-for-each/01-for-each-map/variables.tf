variable "users_map" {
  description = "Map of user names to their configuration"
  type = map(object({
    department = string
    is_admin   = bool
  }))

  default = {
    "alice" = {
      department = "engineering"
      is_admin   = true
    }
    "bob" = {
      department = "marketing"
      is_admin   = false
    }
    "charlie" = {
      department = "finance"
      is_admin   = false
    }
  }
}
