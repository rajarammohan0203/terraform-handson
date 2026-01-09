variable "project_name" {
  type        = string
  default     = "My-Super-Project"
  description = "Project name with mixed case and special chars"
}

variable "environment" {
  type        = string
  default     = "DEV"
  description = "Environment (often passed in UPPERCASE)"
}

variable "subnet_list_string" {
  type        = string
  default     = "10.0.1.0/24,10.0.2.0/24,10.0.3.0/24"
  description = "Comma-separated string of subnets"
}
