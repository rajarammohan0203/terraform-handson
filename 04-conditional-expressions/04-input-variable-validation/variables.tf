variable "environment" {
  description = "Deployment environment name"
  type        = string
  default     = "dev"

  # 1. ENFORCE ALLOWED VALUES
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "ami_id" {
  description = "AMI ID to use"
  type        = string
  default     = "ami-12345678"

  # 2. ENFORCE FORMAT (Regex)
  validation {
    condition     = can(regex("^ami-[a-z0-9]+$", var.ami_id))
    error_message = "AMI ID must start with 'ami-' followed by alphanumeric characters."
  }
}
