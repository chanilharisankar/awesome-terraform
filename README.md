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
devbox run setup    # Set up environment
devbox run plan     # Plan infrastructure changes
devbox run apply    # Apply changes
devbox run destroy  # Destroy infrastructure
devbox run fmt      # Format code
devbox run validate # Validate configuration

# Manual commands
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
├── README.md          # This file
├── DEVBOX.md         # Devbox documentation
├── devbox.json       # Devbox configuration
├── devbox.lock       # Devbox lock file
└── .envrc            # Environment variables (AWS credentials)
```
