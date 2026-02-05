# Using TFE Provider to create Run Triggers

# 1. The Source Workspace (e.g. Networking)
resource "tfe_workspace" "networking" {
  name         = "networking-prod"
  organization = "my-demo-org"
}

# 2. The Target Workspace (e.g. Application)
resource "tfe_workspace" "application" {
  name         = "application-prod"
  organization = "my-demo-org"
}

# 3. The Trigger
# "When Networking updates successfully, auto-plan Application"
resource "tfe_run_trigger" "trigger" {
  workspace_id  = tfe_workspace.application.id
  sourceable_id = tfe_workspace.networking.id
}
