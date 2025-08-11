# AWS Region
variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

# Project Configuration
variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "awesome-terraform"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "owner" {
  description = "Owner of the resources"
  type        = string
  default     = "DevOps Team"
}

# Backend Configuration (for remote state)
variable "backend_bucket" {
  description = "S3 bucket name for storing Terraform state"
  type        = string
  default     = ""
}

variable "backend_key" {
  description = "S3 key path for storing Terraform state"
  type        = string
  default     = "terraform.tfstate"
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}