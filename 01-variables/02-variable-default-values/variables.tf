# Variable with a default value
# If the user doesn't specify one, this value is used.
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.50.0.0/16" 
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.nano" # Smaller default than usual
}

variable "environment_tag" {
  description = "Environment Name"
  type        = string
  default     = "Learning-Env"
}

# Boolean variable with default
variable "enable_monitoring" {
  description = "Enable detailed monitoring"
  type        = bool
  default     = true
}
