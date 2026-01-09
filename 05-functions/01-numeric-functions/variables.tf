variable "requested_instances" {
  type        = number
  default     = 2
  description = "Number of instances requested by the user"
}

variable "cpu_utilization" {
  type        = number
  default     = 75.5
  description = "Current CPU utilization (float)"
}

variable "price_diff" {
  type        = number
  default     = -15
  description = "Price difference (negative means cheaper)"
}
