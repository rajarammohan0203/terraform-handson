variable "bucket_name" {
  default = "my-health-checked-bucket"
}

variable "budget_limit" {
  default     = 100
  description = "Max allowed monthly spend (USD)"
}

variable "current_spend" {
  default     = 50
  description = "Current usage (USD). Change this to 150 to trigger the Check warning."
}
