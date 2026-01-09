# ---------------------------------------------------------------------------------------------------------------------
# EXAMPLE 1: MAX & MIN (Autoscaling Constraints)
# ---------------------------------------------------------------------------------------------------------------------
# SCENARIO: You serve traffic that requires at least 3 servers for High Availability (HA).
# But you also have a strict budget constraint of 10 servers max.
# Even if a user requests 2 servers, you must provision 3.
# Even if a user requests 50 servers, you must strictly limit to 10.

resource "aws_instance" "app_servers" {
  # Logic:
  # 1. max(3, var.requested_instances) -> Ensures we start with AT LEAST 3.
  # 2. min(10, ...) -> Takes result of step 1 and ensures it's NO MORE THAN 10.

  count = min(10, max(3, var.requested_instances))

  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "server-${count.index}"
    Desc = "Managed by Min/Max logic"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# EXAMPLE 2: CEIL (Capacity Planning for CPU)
# ---------------------------------------------------------------------------------------------------------------------
# SCENARIO: You have a total CPU load of 75.5 units. Each server handle 20 units.
# Simple math: 75.5 / 20 = 3.775 servers.
# You cannot trigger 0.775 of a server! You must round UP to 4 servers.

locals {
  instances_needed = ceil(var.cpu_utilization / 20)
}

output "capacity_planning" {
  value = "Load: ${var.cpu_utilization} / 20 per server = ${var.cpu_utilization / 20} -> Round UP to ${local.instances_needed} servers."
}

# ---------------------------------------------------------------------------------------------------------------------
# EXAMPLE 3: FLOOR (Cost Estimation & Budgeting)
# ---------------------------------------------------------------------------------------------------------------------
# SCENARIO: Your finance team wants "conservative" estimates for quarterly reports.
# They ignore cents and always want to see the base dollar amount.
# $99.99 becomes $99.

output "conservative_cost_estimate" {
  value = "Actual: 99.99 -> Finance View: ${floor(99.99)}"
}

# ---------------------------------------------------------------------------------------------------------------------
# EXAMPLE 4: ABS (Price Fluctuation Alerting)
# ---------------------------------------------------------------------------------------------------------------------
# SCENARIO: You want to trigger an alert if the price changes by more than $10.
# It doesn't matter if it went UP ($10) or DOWN ($-10). The magnitude is what matters.

output "price_change_alert" {
  value = abs(var.price_diff) > 10 ? "ALERT: Large Price Change detected ($${abs(var.price_diff)})" : "No alert"
}
