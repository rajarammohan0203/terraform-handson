variable "subnet_count" {
  type        = number
  default     = 3
  description = "How many subnets to create"
}

variable "subnet_cidrs" {
  type = list(string)
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]
  description = "CIDR blocks for subnets (accessed by count.index)"
}
