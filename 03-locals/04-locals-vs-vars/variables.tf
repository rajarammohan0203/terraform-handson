# VARIABLES = INPUTS
# These come from the USER (CLI, tfvars, default).
# We generally cannot "calculate" these using other variables (except simple defaults).

variable "project" {
  type        = string
  default     = "CloudApp"
  description = "The name of the project"
}

variable "env" {
  type        = string
  default     = "dev"
  description = "The environment (dev, prod)"
}
