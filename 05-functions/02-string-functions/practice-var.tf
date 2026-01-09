# PRACTICE: Fix the messy input!
# Uncomment to test.

# variable "messy_input" {
#   type    = string
#   default = "  HeLLo World  "
# }

# # Goal: Output should be "hello-world" (lowercase, no spaces, spaces allowed in middle replaced by dashes)
# # Hint: You might need trim() which removes start/end spaces, but it's not in the main list. 
# # Try using replace() and tolower().

# output "clean_greeting" {
#   value = replace(tolower(var.messy_input), " ", "") # This removes ALL spaces. Try to fix it!
# }
