variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "ami" {
  description = "AMI ID for EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "terraform_state_bucket" {
  description = "S3 bucket for storing Terraform state"
  type        = string
}

variable "owner" {
  description = "Owner of the resources"
  type        = string
}

# variable "vpc_cidr" {
#   description = "VPC CIDR block"
#   type        = string
# }
