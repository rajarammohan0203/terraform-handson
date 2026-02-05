# Example of using a Private Registry Module
# Format: <HOSTNAME>/<ORG>/<NAME>/<PROVIDER>

module "vpc" {
  # Notice the hostname 'app.terraform.io'
  source  = "app.terraform.io/my-demo-org/vpc/aws"
  version = "1.0.0"

  cidr = "10.0.0.0/16"
}

# Advantage:
# 1. Authenticated (only my-demo-org can see this).
# 2. Versioned (We can force users to upgrade).
# 3. Browseable (UI shows Readme and Inputs).
