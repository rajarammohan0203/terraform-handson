# Practice!
# 1. Run the code.
# 2. Verify the database is created (via `aws --endpoint-url=http://localhost:4566 rds describe-db-instances`).
# 3. Verify the state file is clean (Open terraform.tfstate).
# 4. Try to output the password. 
#    output "pw" { value = ephemeral.random_password.db_pass.result }
#    Terraform might error saying you can't output ephemeral values!
