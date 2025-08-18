# variable "vpc_cidr" {
#   description = "CIDR block for the VPC"
#   type        = string
# }

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "vpc_id" {
  description = "VPC ID where resources will be created"
  type        = string
}

variable "ami" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
  default = "ami-0de716d6197524dd9"
}

variable "instance_type" {
  description = "The instance type to use for the EC2 instance"
  type        = string
  default = "t2.micro"
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key file"
  type        = string
  default     = "key.pub"
}