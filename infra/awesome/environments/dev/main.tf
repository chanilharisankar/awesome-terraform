module "infrastructure" {
  source = "../../"

  environment  = var.environment
  vpc_cidr     = var.vpc_cidr
}
