# ---------------------------------------------------------------------------------------------------------------------
# LIST EXAMPLE: Allowed IPs
# ---------------------------------------------------------------------------------------------------------------------
# Real World Scenario: Whitelisting IP addresses in a firewall or Security Group.
# Why List? Order might matter for some firewall rules (though AWS SGs are stateless/unordered, NACLs are ordered).
# More importantly, lists are the standard way to pass multiple strings to arguments like 'cidr_blocks'.

variable "allowed_ips" {
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "192.168.1.5/32"]
  description = "A list of IP ranges allowed to access the system."
}

# ---------------------------------------------------------------------------------------------------------------------
# SET EXAMPLE: IAM Usernames
# ---------------------------------------------------------------------------------------------------------------------
# Real World Scenario: Creating a batch of user accounts.
# Why Set? Usernames MUST be unique. 'alice' and 'alice' cannot exist twice.
# Sets automatically handle deduplication for us.

variable "iam_usernames" {
  type        = set(string)
  default     = ["alice", "bob", "charlie", "alice"] # 'alice' is duplicated here to prove a point!
  description = "A set of usernames. Duplicates will be removed automatically."
}
