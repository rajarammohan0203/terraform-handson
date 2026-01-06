variable "server_count" {
  type        = number
  default     = 3
  description = "How many EC2 instances (servers) to create"
}

variable "server_names" {
  type        = list(string)
  default     = ["dev-amer", "dev-etl", "dev-ameo"]
  description = "Custom names for each server"
}
