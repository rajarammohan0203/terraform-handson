# 03-ec2-import-scenario/main.tf

# 1. Edit this block!
# You must paste the Instance ID you got from the CLI command below.

import {
  to = aws_instance.imported_web_server
  id = "i-xxxxxxxxxxxxxxxxx" # <--- REPLACE THIS with your real ID
}

# 2. Run: terraform plan -generate-config-out=generated.tf
