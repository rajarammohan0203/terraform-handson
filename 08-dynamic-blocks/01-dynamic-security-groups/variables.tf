variable "ingress_ports_list" {
  description = "List of ports to open for the web server"
  type        = list(number)
  default     = [80, 443, 8080, 22]
}
