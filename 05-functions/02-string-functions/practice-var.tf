# ---------------------------------------------------------------------------------------------------------------------
# PRACTICE EXERCISES - STRING FUNCTIONS
# ---------------------------------------------------------------------------------------------------------------------
# Uncomment the variables and outputs to practice each function.
# Run `terraform apply` to see the results.

# ---------------------------------------------------------------------------------------------------------------------
# 1. PRACTICE: LOWER & UPPER
# ---------------------------------------------------------------------------------------------------------------------
# Scenario: Standardize user inputs.
variable "user_input_name" {
  type    = string
  default = "JohnDoe"
}

output "practice_lower" {
  value = lower(var.user_input_name) # Expected: "johndoe"
}

output "practice_upper" {
  value = upper(var.user_input_name) # Expected: "JOHNDOE"
}

# ---------------------------------------------------------------------------------------------------------------------
# 2. PRACTICE: REPLACE
# ---------------------------------------------------------------------------------------------------------------------
# Scenario: Fix file paths or names (replace forward slash with dash)
variable "file_path" {
  type    = string
  default = "path/to/my/file"
}

output "practice_replace" {
  value = replace(var.file_path, "/", "-") # Expected: "path-to-my-file"
}

# ---------------------------------------------------------------------------------------------------------------------
# 3. PRACTICE: SPLIT
# ---------------------------------------------------------------------------------------------------------------------
# Scenario: Convert a comma-separated list of roles into a valid list type
variable "roles_csv" {
  type    = string
  default = "admin,editor,viewer"
}

output "practice_split" {
  value = split(",", var.roles_csv) # Expected: ["admin", "editor", "viewer"]
}

# ---------------------------------------------------------------------------------------------------------------------
# 4. PRACTICE: CONCAT
# ---------------------------------------------------------------------------------------------------------------------
# Scenario: Add a "superuser" role to the list of roles derived from above
output "practice_concat" {
  value = concat(split(",", var.roles_csv), ["superuser"])
  # Expected: ["admin", "editor", "viewer", "superuser"]
}

# ---------------------------------------------------------------------------------------------------------------------
# CHALLENGE: CLEAN MESSY INPUT
# ---------------------------------------------------------------------------------------------------------------------
variable "messy_input" {
  type    = string
  default = "  HeLLo World  "
}

# Goal: Output should be "hello-world" (lowercase, no spaces, spaces allowed in middle replaced by dashes)
output "challenge_solution" {
  # Steps:
  # 1. trim(str, " ") -> Removes LEADING/TRAILING spaces only: "HeLLo World"
  # 2. lower(...)     -> "hello world"
  # 3. replace(..., " ", "-") -> "hello-world"
  value = replace(lower(trim(var.messy_input, " ")), " ", "-")
}
