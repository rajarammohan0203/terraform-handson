variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "The CIDR block for the Subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "os_name" {
    description = "Name of the OS (Tag)"
    type        = string
    default     = "Linux"
}

variable "instance_type" {
    description = "EC2 Instance Type"
    type        = string
    default     = "t2.micro"
}
