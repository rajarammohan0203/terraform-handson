variable "availability_zone" {
  type        = string
  default     = null
  description = "The AZ to deploy to. If null, AWS selects one automatically."
}
