variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment: dev, staging, or prod"
}

variable "create_backup" {
  type        = bool
  default     = false
  description = "Whether to create a backup bucket"
}
