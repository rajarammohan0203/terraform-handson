variable "script_path" {
  type        = string
  default     = "${path.module}/script.sh"
  description = "Path to the script file (using path.module to find it in THIS directory)"
}
