module "multi_region_setup" {
  source = "./modules/multi_region_bucket"

  providers = {
    # Mapping Root Providers -> Module Aliases
    aws.src = aws.primary
    aws.dst = aws.secondary
  }
}
