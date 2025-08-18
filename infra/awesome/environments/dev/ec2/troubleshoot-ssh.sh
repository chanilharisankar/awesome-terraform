#!/bin/bash

# EC2 SSH Connection Troubleshooting Script
# Run this script to diagnose SSH connection issues

echo "=== EC2 SSH Connection Troubleshooting ==="
echo ""

# Get instance information
echo "1. Getting EC2 instance information..."
INSTANCE_ID=$(aws ec2 describe-instances \
  --filters "Name=tag:Project,Values=awesome-terraform" "Name=instance-state-name,Values=running" \
  --query 'Reservations[0].Instances[0].InstanceId' --output text)

if [ "$INSTANCE_ID" = "None" ] || [ -z "$INSTANCE_ID" ]; then
  echo "❌ No running EC2 instance found with Project tag 'awesome-terraform'"
  echo "Please deploy your infrastructure first:"
  echo "cd environments/dev/network && terraform apply"
  echo "cd ../ec2 && terraform apply"
  exit 1
fi

echo "✅ Found instance: $INSTANCE_ID"

# Get public IP
PUBLIC_IP=$(aws ec2 describe-instances \
  --instance-ids $INSTANCE_ID \
  --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)

echo "✅ Public IP: $PUBLIC_IP"

# Check instance state
INSTANCE_STATE=$(aws ec2 describe-instances \
  --instance-ids $INSTANCE_ID \
  --query 'Reservations[0].Instances[0].State.Name' --output text)

echo "✅ Instance State: $INSTANCE_STATE"

# Check security group
SECURITY_GROUP=$(aws ec2 describe-instances \
  --instance-ids $INSTANCE_ID \
  --query 'Reservations[0].Instances[0].SecurityGroups[0].GroupId' --output text)

echo "✅ Security Group: $SECURITY_GROUP"

# Check security group rules
echo ""
echo "2. Checking Security Group SSH rules..."
aws ec2 describe-security-groups \
  --group-ids $SECURITY_GROUP \
  --query 'SecurityGroups[0].IpPermissions[?FromPort==`22`]' \
  --output table

# Check if port 22 is open
echo ""
echo "3. Testing port connectivity..."
echo "Testing telnet to $PUBLIC_IP:22..."
timeout 5 telnet $PUBLIC_IP 22

echo ""
echo "4. SSH Connection attempts:"
echo ""
echo "Try these SSH commands (use the correct username):"
echo "Amazon Linux 2/RHEL: ssh -i ../privatekey ec2-user@$PUBLIC_IP"
echo "Ubuntu:               ssh -i ../privatekey ubuntu@$PUBLIC_IP"
echo "Debian:               ssh -i ../privatekey admin@$PUBLIC_IP"
echo ""
echo "If connection fails, check:"
echo "1. Instance is fully booted (wait 2-3 minutes after launch)"
echo "2. Private key permissions: chmod 400 ../privatekey"
echo "3. Your local firewall/network allows outbound SSH"
echo "4. AWS region is correct"
