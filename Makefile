# Terraform Management Makefile
# Run from project root: awesome-terraform/

# Configuration
PROJECT_ROOT := $(shell pwd)
INFRA_BASE_DIR := infra/awesome

# Colors for output
RED := \033[0;31m
GREEN := \033[0;32m
YELLOW := \033[1;33m
BLUE := \033[0;34m
NC := \033[0m # No Color

# Available environments and modules (auto-discovered)
ENVIRONMENTS := $(shell find $(INFRA_BASE_DIR)/environments -mindepth 1 -maxdepth 1 -type d -exec basename {} \; 2>/dev/null || echo "")
MODULES_FOR_ENV = $(shell find $(INFRA_BASE_DIR)/environments/$(1) -mindepth 1 -maxdepth 1 -type d -exec basename {} \; 2>/dev/null || echo "")

# Terraform action implementations (must be in main Makefile for subdirectory access)
_execute_init:
	terraform init \
		-backend-config="bucket=$${TERRAFORM_STATE_BUCKET:-awesome-terraform-state-bucket}" \
		-backend-config="region=$${AWS_REGION:-us-east-1}"

_execute_plan:
	terraform plan $(COMMON_VARS) -var-file="terraform.tfvars"

_execute_apply:
	terraform apply $(COMMON_VARS) -var-file="terraform.tfvars"

_execute_destroy:
	terraform destroy $(COMMON_VARS) -var-file="terraform.tfvars"

_execute_output:
	terraform output

_execute_validate:
	terraform validate

_execute_show:
	terraform show

_execute_refresh:
	terraform refresh $(COMMON_VARS) -var-file="terraform.tfvars"

_execute_clean:
	rm -rf .terraform .terraform.lock.hcl terraform.tfstate.backup

# Include modular makefiles (only when running from project root)
ifneq ($(wildcard $(PROJECT_ROOT)/makefiles/terraform.mk),)
include $(PROJECT_ROOT)/makefiles/terraform.mk
include $(PROJECT_ROOT)/makefiles/environment.mk
include $(PROJECT_ROOT)/makefiles/utilities.mk
include $(PROJECT_ROOT)/makefiles/development.mk
endif

# Phony targets declaration
.PHONY: help list-envs list-modules fmt fmt-check validate-all clean-all \
        deploy-env destroy-env output-env dev-setup check-env deploy \
        examples

# Default target
help: ## Show this help message
	@printf "$(BLUE)Dynamic Terraform Management$(NC)\n"
	@printf "=============================\n"
	@printf "\n"
	@printf "$(GREEN)Usage Patterns:$(NC)\n"
	@printf "  make environments/<env>/<module>/<action>\n"
	@printf "  make <env>/<module>/<action>\n"
	@printf "\n"
	@printf "$(GREEN)Examples:$(NC)\n"
	@printf "  make environments/dev/network/plan      # Plan dev network\n"
	@printf "  make environments/dev/ec2/apply         # Apply dev EC2\n"
	@printf "  make environments/prod/network/init     # Init prod network\n"
	@printf "  make dev/network/apply                  # Shorthand for dev\n"
	@printf "  make qa/ec2/destroy                     # Destroy qa EC2\n"
	@printf "\n"
	@printf "$(GREEN)Available Actions:$(NC)\n"
	@printf "  init, plan, apply, destroy, output, validate, clean, show, refresh\n"
	@printf "\n"
	@printf "$(GREEN)Global Commands:$(NC)\n"
	@printf "  make list-envs                          # List available environments\n"
	@printf "  make list-modules ENV=dev               # List modules for environment\n"
	@printf "  make fmt                                # Format all Terraform files\n"
	@printf "  make fmt-check                          # Check if files need formatting\n"
	@printf "  make validate-all                       # Validate all configs\n"
	@printf "\n"
	@printf "$(GREEN)Environment Management:$(NC)\n"
	@printf "  make deploy-env ENV=dev                 # Deploy entire environment\n"
	@printf "  make destroy-env ENV=dev                # Destroy entire environment\n"
	@printf "  make output-env ENV=dev                 # Show all environment outputs\n"
	@printf "\n"
	@printf "$(GREEN)Development Tools:$(NC)\n"
	@printf "  make dev-setup                          # Setup DevBox environment\n"
	@printf "  make check-env                          # Check AWS credentials\n"
	@printf "  make deploy                             # Quick deploy dev environment\n"
	@printf "  make examples                           # Show detailed examples\n"
