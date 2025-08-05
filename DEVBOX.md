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

# Plan Terraform changes
devbox run plan

# Apply Terraform changes
devbox run apply

# Destroy infrastructure
devbox run destroy

# Format Terraform code
devbox run fmt

# Validate Terraform configuration
devbox run validate
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
devbox run "terraform init && terraform plan"
```
