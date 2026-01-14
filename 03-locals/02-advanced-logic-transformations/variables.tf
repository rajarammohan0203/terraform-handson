variable "env_name" {
  type        = string
  default     = "PrOd" # Messy input!
  description = "Environment name (e.g. Prod, Dev)"
}

variable "department_code" {
  type    = string
  default = "finance"
}

variable "high_availability" {
  type        = bool
  default     = true
  description = "Whether to enable High Availability"
}
