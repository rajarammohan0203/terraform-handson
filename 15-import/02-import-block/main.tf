# 02-import-block/main.tf

# 1. We Define the Import Block
# We do NOT write the resource block. Terraform will do that for us.

import {
  to = aws_s3_bucket.generated_bucket
  id = "my-manual-bucket-for-block"
}

# 2. Run the command:
# terraform plan -generate-config-out=generated_resources.tf
