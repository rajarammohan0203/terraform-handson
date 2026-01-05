variable "ami_id" {
  description = "The AMI ID to use for the instance"
  type        = string
  default     = "ami-12345678"

  validation {
    condition     = length(var.ami_id) > 4 && substr(var.ami_id, 0, 4) == "ami-"
    error_message = "The AMI ID must start with 'ami-'."
  }
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  
  validation {
    condition     = contains(["dev", "prod", "staging"], var.environment)
    error_message = "Environment must be one of: dev, prod, staging."
  }
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t2.micro"

  validation {
    condition     = contains(["t2.micro", "t2.small"], var.instance_type)
    error_message = "Only t2.micro and t2.small are allowed in this project."
  }
}
