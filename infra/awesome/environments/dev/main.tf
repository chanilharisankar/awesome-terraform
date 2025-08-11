# Development Environment Configuration
terraform {
  backend "s3" {
    bucket = "awesome-terraform-state"
    key    = "dev/terraform.tfstate"
    region = "eu-north-1"
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Environment = "dev"
    }
  }
}

module "infrastructure" {
  source = "../../"

  # Environment specific variables
  project_name = "awesome-terraform"
  environment  = "dev"
  aws_region   = var.aws_region
}
