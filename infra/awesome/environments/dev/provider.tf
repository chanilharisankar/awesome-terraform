# Development Environment Configuration
terraform {
  backend "s3" {
    bucket = "awesome-project-tf-state"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}