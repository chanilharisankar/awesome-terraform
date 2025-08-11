# awesome-terraform

A basic Terraform framework with a complete development environment setup using Devbox.

## Quick Start

### Option 1: Using Devbox (Recommended)

1. **Install Devbox**:
   ```bash
   curl -fsSL https://get.jetpack.io/devbox | bash
   ```

2. **Start the development environment**:
   ```bash
   devbox shell
   ```

3. **Configure AWS credentials**:
   ```bash
   # Edit .envrc with your AWS credentials
   vim .envrc
   
   # Allow direnv to load environment variables
   direnv allow
   ```

4. **Start building**:
   ```bash
   devbox run plan
   ```

### Option 2: Manual Setup

1. **Install required tools**:
   - [Terraform](https://www.terraform.io/downloads.html)
   - [AWS CLI](https://aws.amazon.com/cli/)
   - [direnv](https://direnv.net/)

2. **Configure environment**:
   ```bash
   # Configure AWS credentials in .envrc
   direnv allow
   ```

## Development Environment

This project includes:
- 🏗️ **Terraform** for infrastructure as code
- ☁️ **AWS CLI** for cloud operations
- 🔧 **Devbox** for isolated development environment
- 📁 **direnv** for automatic environment variable loading

## Available Commands

```bash
# Using Devbox (recommended)
devbox run setup    # Set up environment and format code
devbox run plan     # Plan root module infrastructure changes
devbox run apply    # Apply root module changes
devbox run destroy  # Destroy root module infrastructure
devbox run fmt      # Format code
devbox run validate # Validate configuration

# Manual commands (from infra/awesome directory)
cd infra/awesome
terraform init
terraform plan
terraform apply
```

## Documentation

- [Devbox Setup Guide](./DEVBOX.md) - Detailed Devbox usage instructions
- [Environment Variables](./.envrc) - AWS authentication configuration

## Project Structure

```
.
├── README.md                    # This file
├── DEVBOX.md                   # Devbox documentation
├── devbox.json                 # Devbox configuration
├── devbox.lock                 # Devbox lock file
├── .envrc                      # Environment variables (AWS credentials)
├── .gitignore                  # Git ignore rules
└── infra/                      # Infrastructure code
    └── awesome/                # Main infrastructure project
        ├── main.tf             # Main Terraform configuration
        ├── variables.tf        # Root module variables
        ├── outputs.tf          # Root module outputs
        ├── modules.tf          # Module declarations
        ├── modules/            # Reusable Terraform modules
        │   ├── vpc/           # VPC module
        │   │   ├── main.tf
        │   │   ├── variables.tf
        │   │   └── outputs.tf
        │   ├── ec2/           # EC2 module
        │   │   ├── main.tf
        │   │   ├── variables.tf
        │   │   └── outputs.tf
        │   └── s3/            # S3 module
        │       ├── main.tf
        │       ├── variables.tf
        │       └── outputs.tf
        └── environments/      # Environment-specific configurations
            ├── dev/           # Development environment
            │   ├── main.tf
            │   ├── variables.tf
            │   ├── outputs.tf
            │   └── terraform.tfvars.example
            ├── staging/       # Staging environment
            │   ├── main.tf
            │   ├── variables.tf
            │   └── outputs.tf
            └── prod/          # Production environment
                ├── main.tf
                ├── variables.tf
                └── outputs.tf
```

## Infrastructure Components

### VPC Module
- Creates a VPC with public and private subnets
- Sets up Internet Gateway and NAT Gateways
- Configures route tables and security groups
- Supports multiple availability zones

### EC2 Module
- Launches EC2 instances with Amazon Linux 2
- Installs and configures Apache web server
- Supports multiple instances across subnets
- Configurable instance types per environment

### S3 Module
- Creates S3 bucket with versioning enabled
- Configures server-side encryption
- Blocks public access for security
- Generates unique bucket names

## Environment-Specific Deployments

### Development Environment
```bash
# Plan development infrastructure
devbox run dev-plan

# Deploy development infrastructure
devbox run dev-apply

# Destroy development infrastructure
devbox run dev-destroy
```

### Staging Environment
```bash
# Plan staging infrastructure
devbox run staging-plan

# Deploy staging infrastructure
devbox run staging-apply

# Destroy staging infrastructure
devbox run staging-destroy
```

### Production Environment
```bash
# Plan production infrastructure
devbox run prod-plan

# Deploy production infrastructure
devbox run prod-apply

# Destroy production infrastructure
devbox run prod-destroy
```
