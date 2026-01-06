variable "db_settings" {
  # Tuple: A fixed sequence of types.
  # Index 0: Instance Class (string)
  # Index 1: Port (number)
  # Index 2: Multi-AZ Enabled (bool)
  type        = tuple([string, number, bool])
  default     = ["db.t3.micro", 5432, true]
  description = "A strictly ordered tuple for DB config: [class, port, multi_az]"
}
