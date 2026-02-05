variable "lifecycle_rules" {
  description = "List of lifecycle rules to apply"
  type = list(object({
    id              = string
    prefix          = string
    enabled         = bool
    transition_days = optional(number) # Optional!
    storage_class   = optional(string)
    expiration_days = optional(number) # Optional!
  }))

  default = [
    # Rule 1: Move logs to IA after 30 days, delete after 365
    {
      id              = "logs-rule"
      prefix          = "logs/"
      enabled         = true
      transition_days = 30
      storage_class   = "STANDARD_IA"
      expiration_days = 365
    },
    # Rule 2: Just delete temporary files after 7 days
    {
      id              = "tmp-rule"
      prefix          = "tmp/"
      enabled         = true
      transition_days = null # Skip transition
      storage_class   = null
      expiration_days = 7
    }
  ]
}
