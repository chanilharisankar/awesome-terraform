# awesome-terraform

A simplified Terraform framework for AWS VPC networking infrastructure with DevBox development environment.

## Quick Start

### Option 1: Using DevBox (Recommended)

1. **Install DevBox**:
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


### Option 2: Manual Setup

1. **Install required tools**:
   - [Terraform](https://www.terraform.io/downloads.html) (v1.12.2+)
   - [AWS CLI](https://aws.amazon.com/cli/)
   - [direnv](https://direnv.net/)

2. **Configure environment**:
   ```bash
   # Configure AWS credentials in .envrc
   direnv allow
   ```

## Development Environment

This project includes:
- 🏗️ **Terraform v1.12.2** for infrastructure as code
- ☁️ **AWS CLI** for cloud operations
- 🔧 **DevBox** for isolated development environment
- 📁 **direnv** for automatic environment variable loading


## Project Structure

```
.
├── README.md                           # This file
├── devbox.json                         # DevBox configuration
├── devbox.lock                         # DevBox lock file
├── .envrc                              # Environment variables (AWS credentials)
├── .gitignore                          # Git ignore rules
└── infra/                              # Infrastructure code
    └── awesome/                        # Main infrastructure project
        ├── deploy.sh                   # Deployment script
        ├── environments/               # Environment configurations
        │   ├── common.tfvars          # Global project variables
        │   └── dev/                   # Development environment
        │       ├── common.tfvars      # Dev environment variables
        │       └── network/           # Network infrastructure layer
        │           ├── main.tf        # Terraform configuration
        │           ├── provider.tf    # Provider & backend config
        │           ├── variables.tf   # Variable definitions
        │           ├── outputs.tf     # Infrastructure outputs
        │           └── terraform.tfvars # Network-specific variables
        └── modules/                    # Reusable Terraform modules
            └── network/                # VPC networking module
                ├── main.tf             # VPC, subnets, gateways
                ├── variables.tf        # Module variables
                └── outputs.tf          # Module outputs
```

## Variable Hierarchy

The project uses a hierarchical variable system with override precedence:

1. **`environments/common.tfvars`** - Global project settings
2. **`environments/dev/common.tfvars`** - Development environment settings  
3. **`environments/dev/network/terraform.tfvars`** - Network layer specific settings

## Infrastructure Components


## Getting Started

### 1. Configure AWS Credentials

Edit `.envrc` file with your AWS credentials:
```bash
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="eu-north-1"
```

### 2. Initialize and Deploy

```bash
# Start DevBox environment
devbox shell

# Navigate to infrastructure directory
cd infra/awesome

### 3. Configuration Files

**Global Variables** (`environments/common.tfvars`):
```hcl
project_name = "awesome-terraform"
owner        = "DevOps Team"
aws_region   = "eu-north-1"
```

**Environment Variables** (`environments/dev/common.tfvars`):
```hcl
project_name = "awesome-terraform"
environment  = "dev"
aws_region   = "eu-north-1"
owner        = "DevOps Team"
```


## Advanced Usage

### Adding New Environments
To add staging or production:
1. Create `environments/staging/` or `environments/prod/` directories
2. Copy the network layer structure
3. Update variable files with environment-specific values
4. Update backend state keys for isolation

### Adding New Modules
To add compute, storage, or other layers:
1. Create new module in `environments/dev/` (e.g., `compute/`)
2. Create corresponding module in `modules/` directory
3. Set up proper state file isolation
4. Configure variable hierarchy

## DevBox Features

- ✅ **Terraform v1.12.2** - Latest stable version
- ✅ **AWS CLI** - For cloud operations
- ✅ **direnv** - Automatic environment loading
- ✅ **Git** - Version control
- ✅ **curl & jq** - For API interactions and JSON processing

## State Management

- **Backend**: AWS S3
- **State Location**: `s3://awesome-terraform-state/dev/terraform.tfstate`
- **Locking**: DynamoDB (optional, can be added)
- **Isolation**: One state file per environment/layer combination

## Security Best Practices

- ✅ AWS credentials managed via environment variables
- ✅ State files stored in private S3 bucket
- ✅ Proper IAM roles and policies (implement as needed)
- ✅ Resource tagging for cost tracking and compliance