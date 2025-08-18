# EC2 Module Outputs

output "instance_ids" {
  description = "List of EC2 instance IDs"
  value       = [aws_instance.public_instance.id]
}

output "instance_public_ips" {
  description = "List of public IP addresses"
  value       = [aws_instance.public_instance.public_ip]
}

output "instance_private_ips" {
  description = "List of private IP addresses"
  value       = [aws_instance.public_instance.private_ip]
}

output "key_pair_name" {
  description = "Name of the SSH key pair"
  value       = aws_key_pair.deployer.key_name
}

output "security_group_id" {
  description = "Security group ID for EC2 instances"
  value       = aws_security_group.ec2_sg.id
}

# SSH Connection Information
output "ssh_connection_command" {
  description = "SSH command to connect to the instance"
  value       = "ssh -i ~/.ssh/id_rsa ec2-user@${aws_instance.public_instance.public_ip}"
}
