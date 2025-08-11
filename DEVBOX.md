# Devbox Development Environment

This project uses [Devbox](https://www.jetpack.io/devbox) to create a consistent, isolated development environment.

## What's Included

- **Terraform** - Infrastructure as Code tool
- **AWS CLI** - Command line interface for AWS
- **direnv** - Environment variable management
- **Git** - Version control
- **curl** - HTTP client
- **jq** - JSON processor

## Getting Started

### 1. Install Devbox

```bash
curl -fsSL https://get.jetpack.io/devbox | bash
```

### 2. Start the Development Environment

```bash
devbox shell
```

This will:
- Install all required tools in an isolated environment
- Display welcome message with available tools
- Set up the development environment

### 3. Configure AWS Credentials

Update the `.envrc` file with your AWS credentials:

```bash
# Edit .envrc with your actual AWS credentials
vim .envrc

# Allow direnv to load the environment variables
direnv allow
```

## Available Scripts

Devbox provides convenient scripts for common Terraform operations:

```bash
# Set up the environment and format code
devbox run setup

# Root module operations (from infra/awesome/)
devbox run plan     # Plan root module changes
devbox run apply    # Apply root module changes
devbox run destroy  # Destroy root module infrastructure

# Environment-specific operations
devbox run dev-plan     # Plan dev environment
devbox run dev-apply    # Apply dev environment
devbox run dev-destroy  # Destroy dev environment

devbox run staging-plan     # Plan staging environment
devbox run staging-apply    # Apply staging environment
devbox run staging-destroy  # Destroy staging environment

devbox run prod-plan     # Plan production environment
devbox run prod-apply    # Apply production environment
devbox run prod-destroy  # Destroy production environment

# Code quality
devbox run fmt      # Format Terraform code
devbox run validate # Validate Terraform configuration
```

## Benefits of Using Devbox

- **Consistent Environment**: Everyone on the team uses the same tool versions
- **Isolated Dependencies**: No conflicts with system-installed tools
- **Easy Onboarding**: New team members can get started with one command
- **Reproducible Builds**: Same environment across development, CI/CD, and production

## Alternative Usage

If you prefer not to enter the shell, you can run commands directly:

```bash
# Run a single command in the devbox environment
devbox run terraform --version

# Execute multiple commands
devbox run "cd infra/awesome && terraform init && terraform plan"

# Work with specific environments
devbox run "cd infra/awesome/environments/dev && terraform plan"
```
