# Utility Commands
# Formatting, validation, cleanup, and discovery commands

####################
# Discovery Commands #
####################

list-envs: ## List available environments
	@printf "$(BLUE)Available Environments:$(NC)\n"
	@find $(INFRA_BASE_DIR)/environments -mindepth 1 -maxdepth 1 -type d -exec basename {} \; 2>/dev/null | sort | sed 's/^/  /' || printf "  No environments found\n"

list-modules: ## List modules for environment (usage: make list-modules ENV=dev)
	@if [ -z "$(ENV)" ]; then \
		printf "$(RED)Usage: make list-modules ENV=<environment>$(NC)\n"; \
		printf "Available environments: $(ENVIRONMENTS)\n"; \
		exit 1; \
	fi
	@printf "$(BLUE)Available Modules for $(ENV):$(NC)\n"
	@find $(INFRA_BASE_DIR)/environments/$(ENV) -mindepth 1 -maxdepth 1 -type d -exec basename {} \; 2>/dev/null | sort | sed 's/^/  /' || printf "  No modules found for $(ENV)\n"

###################
# Format Commands #
###################

fmt: ## Format all Terraform files
	@printf "$(BLUE)Formatting all Terraform files...$(NC)\n"
	@printf "$(YELLOW)Searching for .tf and .tfvars files...$(NC)\n"
	@FILES_FOUND=0; \
	for file in $$(find $(INFRA_BASE_DIR) -name "*.tf" -o -name "*.tfvars" 2>/dev/null); do \
		printf "  Formatting: $$file\n"; \
		terraform fmt "$$file" >/dev/null 2>&1; \
		FILES_FOUND=$$((FILES_FOUND + 1)); \
	done; \
	if [ $$FILES_FOUND -eq 0 ]; then \
		printf "$(YELLOW)No Terraform files found in $(INFRA_BASE_DIR)$(NC)\n"; \
	else \
		printf "$(GREEN)✅ Formatted $$FILES_FOUND Terraform files$(NC)\n"; \
	fi

fmt-check: ## Check if files need formatting (returns exit code 1 if formatting needed)
	@printf "$(BLUE)Checking Terraform file formatting...$(NC)\n"
	@NEEDS_FORMAT=0; \
	for file in $$(find $(INFRA_BASE_DIR) -name "*.tf" -o -name "*.tfvars" 2>/dev/null); do \
		if ! terraform fmt -check "$$file" >/dev/null 2>&1; then \
			printf "$(YELLOW)  Needs formatting: $$file$(NC)\n"; \
			NEEDS_FORMAT=$$((NEEDS_FORMAT + 1)); \
		fi; \
	done; \
	if [ $$NEEDS_FORMAT -eq 0 ]; then \
		printf "$(GREEN)✅ All files are properly formatted$(NC)\n"; \
	else \
		printf "$(RED)❌ $$NEEDS_FORMAT files need formatting. Run 'make fmt' to fix.$(NC)\n"; \
		exit 1; \
	fi

####################
# Validation Commands #
####################

validate-all: ## Validate all Terraform configurations
	@printf "$(BLUE)Validating all Terraform configurations...$(NC)\n"
	@ENVS=$$(find $(INFRA_BASE_DIR)/environments -mindepth 1 -maxdepth 1 -type d -exec basename {} \;); \
	for env in $$ENVS; do \
		MODULES=$$(find $(INFRA_BASE_DIR)/environments/$$env -mindepth 1 -maxdepth 1 -type d -exec basename {} \;); \
		for module in $$MODULES; do \
			printf "$(YELLOW)Validating $$env/$$module...$(NC)\n"; \
			$(MAKE) --no-print-directory $$env/$$module/validate 2>/dev/null || printf "$(RED)❌ Validation failed for $$env/$$module$(NC)\n"; \
		done; \
	done

###################
# Cleanup Commands #
###################

clean-all: ## Clean all Terraform temporary files
	@printf "$(BLUE)Cleaning all Terraform temporary files...$(NC)\n"
	@find $(INFRA_BASE_DIR) -name ".terraform" -type d -exec rm -rf {} + 2>/dev/null || true
	@find $(INFRA_BASE_DIR) -name ".terraform.lock.hcl" -delete 2>/dev/null || true
	@find $(INFRA_BASE_DIR) -name "terraform.tfstate.backup" -delete 2>/dev/null || true
	@printf "$(GREEN)✅ Cleanup complete!$(NC)\n"
