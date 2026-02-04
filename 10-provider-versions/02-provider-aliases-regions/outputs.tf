output "us_bucket_region" {
  value = aws_s3_bucket.us_bucket.region
}

output "eu_bucket_region" {
  value = aws_s3_bucket.eu_bucket.region
}
