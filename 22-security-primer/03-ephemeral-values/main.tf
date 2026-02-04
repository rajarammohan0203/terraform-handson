# ⚠ NOTE: This syntax requires Terraform v1.10+ and a Provider that supports Ephemeral Resources.
# As of early 2025, this is a cutting-edge feature.

terraform {
  # We require a version that supports ephemeral blocks
  required_version = ">= 1.10.0"
}

# SCENARIO:
# We need to run a script that requires a Super-Sensitive "One-Time-Token".
# We DO NOT want this token stored in the terraform.tfstate file.

# 1. Define an Ephemeral Input (Simulated)
# In a real scenario, this comes from a Vault Provider or similar.
# For this demo, we use a variable marked as ephemeral.
variable "session_token" {
  type      = string
  ephemeral = true # <--- MAGIC: Terraform will NOT save this to state
  default   = "temporary-admin-token-12345"
}

# 2. Use it in a resource that supports ephemeral handling or actions
resource "terraform_data" "deploy_action" {

  # The 'input' argument here normally goes to state. 
  # BUT, if we use it ONLY in a provisioner, we might limit exposure.

  # However, the TRUE power of ephemeral values is when passed to
  # other EPHEMERAL resources or compatible provider fields.

  provisioner "local-exec" {
    # This command uses the token.
    # Because 'var.session_token' is ephemeral, Terraform ensures it 
    # doesn't stick around in the permanent record of this resource.
    command = "echo 'Deploying with token: ${var.session_token}' >> deploy_log.txt"
  }
}

# 3. An "Ephemeral Resource" (Conceptual Syntax)
# This block defines a resource that exists ONLY during the run.
# It is NOT saved to the state file.
/*
ephemeral "aws_secretsmanager_secret_version" "temp_creds" {
  secret_id = "my-prod-db-creds"
}

resource "null_resource" "db_init" {
  provisioner "local-exec" {
    command = "psql -P ${ephemeral.aws_secretsmanager_secret_version.temp_creds.secret_string} ..."
  }
}
*/
