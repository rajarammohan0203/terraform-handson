terraform {
  required_version = ">= 1.10.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

# 1. THE EPHEMERAL RESOURCE
# This generates a password BUT DOES NOT STORE IT IN THE STATE FILE.
# It exists memory-only for this run.
ephemeral "random_password" "db_pass" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# 2. THE CONSUMER RESOURCE
# We pass the ephemeral password to the AWS RDS instance.
resource "aws_db_instance" "prod_db" {
  allocated_storage = 10
  db_name           = "mydb"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  username          = "admin"

  # CRITICAL SECURITY CONFIGURATION:
  # 1. We use the 'ephemeral' value.
  # 2. The 'password' argument in aws_db_instance is "Write-Only" (conceptually).
  #
  # Result:
  # - Terraform sends password to AWS API.
  # - AWS creates DB.
  # - Terraform saves 'aws_db_instance' to state, BUT...
  #   - AWS API does not return the password.
  #   - Terraform does NOT store the input 'password' in state because it came from an ephemeral source? 
  #   (Wait, actually, usually TF stores inputs in state. With ephemeral inputs, TF *should* prevent persistence).

  # UPDATED: Using the 'Write-Only' specific argument pattern
  # 'password_wo' (Write-Only) tells the provider: "Take this value, set it, but never store it or read it back."
  # 'password_wo_version' allows for rotation. Changing the version forces an update.
  password_wo         = ephemeral.random_password.db_pass.result
  password_wo_version = 1


  skip_final_snapshot = true
}
