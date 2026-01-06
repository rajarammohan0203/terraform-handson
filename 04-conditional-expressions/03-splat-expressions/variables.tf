variable "instance_count" {
  type        = number
  default     = 3
  description = "Number of instances to create"
}

variable "bucket_count" {
  type        = number
  default     = 2
  description = "Number of S3 buckets to create"
}
