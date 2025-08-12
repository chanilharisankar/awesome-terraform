# VPC Module - Network Infrastructure
module "vpc" {
  source = "../../../modules/network"

  project_name = var.project_name
  environment  = var.environment
  vpc_cidr     = var.vpc_cidr
}
