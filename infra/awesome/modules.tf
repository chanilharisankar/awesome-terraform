# S3 Module
module "s3" {
  source = "./modules/s3"

  project_name = var.project_name
  environment  = var.environment
}

# Network Module
module "network" {
  source = "./modules/network"

  vpc_cidr = var.vpc_cidr
  project_name = var.project_name
  environment  = var.environment
}
