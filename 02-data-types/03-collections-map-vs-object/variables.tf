# MAP: Uniform types (all strings here)
variable "project_tags" {
  type = map(string)
  default = {
    Environment = "Dev"
    Project     = "LearningTerraform"
    ManagedBy   = "Terraform"
  }
  description = "A map of tags. All values must be strings."
}

# OBJECT: Mixed types covering the configuration of an instance
variable "instance_config" {
  type = object({
    ami           = string
    instance_type = string
    monitoring    = bool
    volume_size   = number
  })
  default = {
    ami           = "ami-0c55b159cbfafe1f0"
    instance_type = "t3.micro"
    monitoring    = false
    volume_size   = 20
  }
  description = "An object allowing mixed types to define a specific configuration."
}
