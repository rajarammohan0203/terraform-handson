variable "common_tags" {
  type = map(string)
  default = {
    Environment = "Dev"
    Owner       = "Team A"
  }
  description = "Tags required on ALL resources"
}

variable "project_tags" {
  type = map(string)
  default = {
    Project    = "Website"
    CostCenter = "1234"
    Owner      = "Specific Team" # This duplicates Owner! merge() will handle it.
  }
  description = "Tags specific to this project"
}

variable "availability_zones" {
  type        = list(string)
  default     = ["us-east-1c", "us-east-1a", "us-east-1b"]
  description = "Unsorted list of AZs"
}
