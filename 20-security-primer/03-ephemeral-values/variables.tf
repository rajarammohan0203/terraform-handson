# Updated variables for the real-time example
variable "aws_region" {
  default = "us-east-1"
}

# The star of the show:
variable "api_key" {
  type        = string
  description = "A key that should never be in the state file"
  ephemeral   = true # <--- This prevents state persistence
  default     = "sensitive-api-key-999"
}
