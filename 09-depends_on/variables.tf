variable "bucket_name" {
  default     = "dependency-demo-bucket-unique-123"
  description = "A unique name for the S3 bucket"
}

variable "instance_name" {
  default = "web-server-v1"
}
