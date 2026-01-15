variable "env" {
  default = "dev"
}

# 1. Map for LOOKUP example
variable "instance_size" {
  type = map(string)
  default = {
    dev  = "t2.micro"
    prod = "t2.large"
    # Note: "staging" is missing! We will use lookup to handle this safely.
  }
}

variable "common_tags" {
  type = map(string)
  default = {
    Project = "DataAPI"
    Owner   = "TeamA"
  }
}

variable "extra_tags" {
  type = map(string)
  default = {
    CostCenter = "1234"
    Status     = "Active"
  }
}
