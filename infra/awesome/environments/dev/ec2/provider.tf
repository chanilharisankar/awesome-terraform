terraform {
  required_version = ">= 1.12"

  backend "s3" {
    key = "dev/ec2/terraform.tfstate"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.8"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Owner       = var.owner
    }
  }
}

# Data source to access network layer outputs
data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = var.terraform_state_bucket
    key    = "dev/network/terraform.tfstate"
    region = var.aws_region
  }
}
