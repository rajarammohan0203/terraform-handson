terraform {
  # THE MIGRATION BLOCK
  # 1. We replace 'backend "s3"' or 'backend "local"' with 'cloud'.
  # 2. This tells Terraform to send the state to HCP.

  cloud {
    organization = "my-demo-org" # <--- REPLACE THIS with your real Org name

    workspaces {
      name = "my-first-cloud-workspace"
    }
  }

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}
