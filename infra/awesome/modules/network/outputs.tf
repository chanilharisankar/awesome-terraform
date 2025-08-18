output "public_subnet_ids" {
  value = aws_subnet.public_subnet.*.id
  description = "List of public subnet IDs"
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnet.*.id
  description = "List of private subnet IDs"
}

output "vpc_cidr_block" {
  value = aws_vpc.main.cidr_block
  description = "VPC CIDR block"
}

output "vpc_id" {
  value = aws_vpc.main.id
  description = "VPC ID"
}