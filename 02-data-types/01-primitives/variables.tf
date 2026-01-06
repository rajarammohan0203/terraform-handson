variable "ami_id" {
  type        = string
  description = "The ID of the AMI to use for the instance (e.g., ami-12345678)"
}

variable "instance_count" {
  type        = number
  description = "Number of instances to launch"
}

variable "enable_public_ip" {
  type        = bool
  description = "Whether to assign a public IP to the instance"
}
