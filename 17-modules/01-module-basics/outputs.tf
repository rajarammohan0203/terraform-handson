# Exposing Child Outputs to the Root

output "logs_bucket_arn" {
  value = module.logs_bucket.bucket_arn
}

output "assets_bucket_arn" {
  value = module.assets_bucket.bucket_arn
}
