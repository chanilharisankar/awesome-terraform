# Development Tools and Quick Deploy
# DevBox setup, environment checks, and quick deployment commands

######################
# Development Tools  #
######################

dev-setup: ## Setup development environment (DevBox)
	@printf "$(BLUE)Setting up development environment...$(NC)\n"
	@if command -v devbox >/dev/null 2>&1; then \
		devbox install; \
		printf "$(GREEN)DevBox environment ready!$(NC)\n"; \
	else \
		printf "$(RED)DevBox not found. Please install it first.$(NC)\n"; \
		printf "Visit: https://www.jetpack.io/devbox/docs/installing_devbox/\n"; \
	fi

check-env: ## Check required environment variables
	@printf "$(BLUE)Checking Environment Variables...$(NC)\n"
	@if [ -z "$$AWS_ACCESS_KEY_ID" ]; then printf "$(RED)❌ AWS_ACCESS_KEY_ID not set$(NC)\n"; else printf "$(GREEN)✅ AWS_ACCESS_KEY_ID$(NC)\n"; fi
	@if [ -z "$$AWS_SECRET_ACCESS_KEY" ]; then printf "$(RED)❌ AWS_SECRET_ACCESS_KEY not set$(NC)\n"; else printf "$(GREEN)✅ AWS_SECRET_ACCESS_KEY$(NC)\n"; fi
	@if [ -z "$$AWS_REGION" ]; then printf "$(YELLOW)⚠️  AWS_REGION not set (will use us-east-1)$(NC)\n"; else printf "$(GREEN)✅ AWS_REGION=$$AWS_REGION$(NC)\n"; fi

######################
# Quick Deploy       #
######################

deploy: check-env ## Quick deploy for dev environment
	@$(MAKE) deploy-env ENV=dev

########################
# Pattern Examples     #
########################

examples: ## Show usage examples
	@printf "$(BLUE)Usage Examples:$(NC)\n"
	@printf "\n"
	@printf "$(GREEN)Individual Module Operations:$(NC)\n"
	@printf "  make dev/network/init            # Initialize dev network\n"
	@printf "  make dev/network/plan            # Plan dev network changes\n"
	@printf "  make dev/network/apply           # Apply dev network\n"
	@printf "  make dev/ec2/apply               # Apply dev EC2\n"
	@printf "  make prod/network/destroy        # Destroy prod network\n"
	@printf "\n"
	@printf "$(GREEN)Environment Operations:$(NC)\n"
	@printf "  make deploy-env ENV=dev          # Deploy entire dev environment\n"
	@printf "  make deploy-env ENV=prod         # Deploy entire prod environment\n"
	@printf "  make destroy-env ENV=qa          # Destroy entire qa environment\n"
	@printf "  make output-env ENV=dev          # Show all dev outputs\n"
	@printf "\n"
	@printf "$(GREEN)Discovery Commands:$(NC)\n"
	@printf "  make list-envs                   # List available environments\n"
	@printf "  make list-modules ENV=dev        # List modules in dev\n"
	@printf "\n"
	@printf "$(GREEN)Maintenance:$(NC)\n"
	@printf "  make fmt                         # Format all files\n"
	@printf "  make validate-all                # Validate all configs\n"
	@printf "  make clean-all                   # Clean all temp files\n"
