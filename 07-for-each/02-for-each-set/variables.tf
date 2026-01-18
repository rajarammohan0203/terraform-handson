variable "bucket_names" {
  description = "A Simple List of names"
  type        = list(string)
  default     = ["assets", "logs", "backups"]
}

variable "user_names" {
  description = "List of IAM user names to create"
  type        = list(string)
  default     = ["alice", "bob", "charlie"]
}
