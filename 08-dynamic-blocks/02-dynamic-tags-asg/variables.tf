variable "custom_tags" {
  description = "Map of tags to apply to the ASG"
  type        = map(string)
  default = {
    Environment = "Production"
    Project     = "Terraform-Handson"
    Owner       = "DevOps-Team"
    CostCenter  = "CC-123"
  }
}
