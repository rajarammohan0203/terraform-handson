module "networking" {
  source = "./modules/networking"

  environment        = var.environment
  vpc_cidr           = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
}

module "compute" {
  source = "./modules/compute"

  environment   = var.environment
  vpc_id        = module.networking.vpc_id
  subnet_id     = module.networking.public_subnet_id
  instance_type = "t3.micro"
}
