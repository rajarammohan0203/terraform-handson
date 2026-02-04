resource "random_pet" "bucket_suffix" {
  length = 4
}

resource "aws_s3_bucket" "this" {
  bucket = "my-prod-bucket-${random_pet.bucket_suffix.id}"

  tags = {
    Name        = "VersionPinnedBucket"
    Description = "Created with a safe, pinned provider version"
  }
}
