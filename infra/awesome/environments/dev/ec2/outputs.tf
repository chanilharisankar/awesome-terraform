# EC2 Infrastructure Outputs

output "instance_ids" {
  description = "List of EC2 instance IDs"
  value       = module.ec2.instance_ids
}

output "instance_public_ips" {
  description = "List of public IP addresses for SSH connection"
  value       = module.ec2.instance_public_ips
}

output "instance_private_ips" {
  description = "List of private IP addresses"
  value       = module.ec2.instance_private_ips
}

output "ssh_connection_command" {
  description = "SSH command to connect to the instance"
  value       = "ssh -i ../privatekey ec2-user@${module.ec2.instance_public_ips[0]}"
}

output "key_pair_name" {
  description = "Name of the SSH key pair"
  value       = module.ec2.key_pair_name
}
