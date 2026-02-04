resource "aws_s3_bucket" "app_data" {
  bucket = "my-app-data-bucket"
}

# Note: We are creating a bucket HERE in the TF code.
# But we are storing the State File in *ANOTHER* S3 bucket defined in provider.tf.
# That "Backend Bucket" MUST be created manually before you run 'terraform init'.
