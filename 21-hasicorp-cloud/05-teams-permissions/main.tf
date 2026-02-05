# Managing TFC Teams with Terraform Code!

resource "tfe_team" "developers" {
  name         = "developers"
  organization = "my-demo-org" # Matches your TFC Org
}

resource "tfe_team" "admins" {
  name         = "platform-admins"
  organization = "my-demo-org"
}

# Create a workspace
resource "tfe_workspace" "app_workspace" {
  name         = "my-app-prod"
  organization = "my-demo-org"
}

# Assign Access: Developers can Plan/Apply
resource "tfe_team_access" "dev_access" {
  access       = "write" # write = plan & apply
  team_id      = tfe_team.developers.id
  workspace_id = tfe_workspace.app_workspace.id
}

# Assign Access: Admins have Admin
resource "tfe_team_access" "admin_access" {
  access       = "admin"
  team_id      = tfe_team.admins.id
  workspace_id = tfe_workspace.app_workspace.id
}
