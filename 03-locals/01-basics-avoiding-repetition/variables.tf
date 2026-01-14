variable "project_name" {
  type        = string
  default     = "marketing-campaign"
  description = "Name of the project"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Deployment environment"
}
