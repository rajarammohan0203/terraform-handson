variable "target_vpc_tag" {
  type        = string
  default     = "Default"
  description = "Tag Name to search for VPC"
}

variable "instance_name" {
  type    = string
  default = "data-source-demo-vm"
}
