variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment: dev, staging, or prod"
}

variable "enable_monitoring" {
  type        = bool
  default     = false
  description = "Enable detailed monitoring"
}
