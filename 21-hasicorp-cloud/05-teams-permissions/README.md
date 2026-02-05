# 05-teams-permissions: RBAC

## Management via Code

The best way to manage Terraform Cloud is... with Terraform.
Using the `hashicorp/tfe` provider, you can define your Teams, Workspaces, and Permissions as code.

## Permission Levels

1.  **Read**: Can view runs and state. Cannot apply.
2.  **Plan**: Can run `terraform plan` but cannot apply.
3.  **Write**: Can run `terraform apply` (normal developer).
4.  **Admin**: Can change settings and delete the workspace.

## How to use

1.  Generate a User Token in HCP Terraform.
2.  `export TFE_TOKEN="your-token"`
3.  `terraform init && terraform apply`
4.  This creates the real teams in your Cloud Organization!
