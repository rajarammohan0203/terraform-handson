variable "app_name" {
  type    = string
  default = "payment-service"
}

variable "env" {
  type    = string
  default = "prod-us-east-1"
}

variable "extra_settings" {
  type = map(string)
  default = {
    tier = "frontend"
    zone = "public"
  }
}
