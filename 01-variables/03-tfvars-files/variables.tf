variable "environment_name" {
  description = "Name of the environment (dev, prod)"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "instance_count" {
  description = "Number of instances to launch"
  type        = number
}

variable "instance_type" {
  description = "Type of EC2 instance (e.g., t2.micro, m5.large)"
  type        = string
}

variable "enable_logging" {
  description = "Boolean to enable logging"
  type        = bool
}
