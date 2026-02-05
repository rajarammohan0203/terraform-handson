# ---------------------------------------------------------------------------------------------------------------------
# ROOT MODULE (The Caller)
# ---------------------------------------------------------------------------------------------------------------------
# We "call" the child module using a `module` block.
# It feels like creating a Resource, but "source" points to a folder.

# INSTANCE 1: LOGS BUCKET
module "logs_bucket" {
  source = "./modules/s3_storage" # Path to the child folder

  # Passing inputs (variables)
  bucket_name = "my-app-logs-001"
  environment = "dev"
}

# INSTANCE 2: ASSETS BUCKET
module "assets_bucket" {
  source = "./modules/s3_storage"

  # Reusing the SAME code with DIFFERENT inputs
  bucket_name = "my-app-assets-001"
  environment = "prod"
}
