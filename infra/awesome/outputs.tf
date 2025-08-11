## VPC Outputs
#output "vpc_id" {
#  description = "ID of the VPC"
#  value       = module.vpc.vpc_id
#}
#
#output "vpc_cidr_block" {
#  description = "CIDR block of the VPC"
#  value       = module.vpc.vpc_cidr_block
#}
#
#output "public_subnet_ids" {
#  description = "IDs of the public subnets"
#  value       = module.vpc.public_subnet_ids
#}
#
#output "private_subnet_ids" {
#  description = "IDs of the private subnets"
#  value       = module.vpc.private_subnet_ids
#}
#
#output "internet_gateway_id" {
#  description = "ID of the Internet Gateway"
#  value       = module.vpc.internet_gateway_id
#}
#
## EC2 Outputs
#output "instance_ids" {
#  description = "IDs of the EC2 instances"
#  value       = module.ec2.instance_ids
#}
#
#output "instance_public_ips" {
#  description = "Public IP addresses of the EC2 instances"
#  value       = module.ec2.instance_public_ips
#}
#
#output "instance_private_ips" {
#  description = "Private IP addresses of the EC2 instances"
#  value       = module.ec2.instance_private_ips
#}
#
## S3 Outputs
#output "s3_bucket_name" {
#  description = "Name of the S3 bucket"
#  value       = module.s3.bucket_name
#}
#
# output "s3_bucket_arn" {
#  description = "ARN of the S3 bucket"
#  value       = module.s3.bucket_arn
# }
