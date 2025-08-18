# Environment Management Operations
# Deploy, destroy, and manage entire environments

#######################
# Environment Actions #
#######################

deploy-env: ## Deploy entire environment (usage: make deploy-env ENV=dev)
	@if [ -z "$(ENV)" ]; then \
		printf "$(RED)Usage: make deploy-env ENV=<environment>$(NC)\n"; \
		printf "Available environments: $(ENVIRONMENTS)\n"; \
		exit 1; \
	fi
	@printf "$(BLUE)Deploying entire $(ENV) environment...$(NC)\n"
	@MODULES=$$(find $(INFRA_BASE_DIR)/environments/$(ENV) -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort); \
	for module in $$MODULES; do \
		printf "$(YELLOW)Deploying $(ENV)/$$module...$(NC)\n"; \
		$(MAKE) --no-print-directory $(ENV)/$$module/apply || exit 1; \
	done
	@printf "$(GREEN)✅ $(ENV) environment deployment complete!$(NC)\n"

destroy-env: ## Destroy entire environment (usage: make destroy-env ENV=dev)
	@if [ -z "$(ENV)" ]; then \
		printf "$(RED)Usage: make destroy-env ENV=<environment>$(NC)\n"; \
		printf "Available environments: $(ENVIRONMENTS)\n"; \
		exit 1; \
	fi
	@printf "$(RED)Destroying entire $(ENV) environment...$(NC)\n"
	@MODULES=$$(find $(INFRA_BASE_DIR)/environments/$(ENV) -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort -r); \
	for module in $$MODULES; do \
		printf "$(YELLOW)Destroying $(ENV)/$$module...$(NC)\n"; \
		$(MAKE) --no-print-directory $(ENV)/$$module/destroy || exit 1; \
	done
	@printf "$(GREEN)✅ $(ENV) environment destruction complete!$(NC)\n"

output-env: ## Show outputs for entire environment (usage: make output-env ENV=dev)
	@if [ -z "$(ENV)" ]; then \
		printf "$(RED)Usage: make output-env ENV=<environment>$(NC)\n"; \
		printf "Available environments: $(ENVIRONMENTS)\n"; \
		exit 1; \
	fi
	@printf "$(BLUE)Outputs for $(ENV) environment:$(NC)\n"
	@MODULES=$$(find $(INFRA_BASE_DIR)/environments/$(ENV) -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort); \
	for module in $$MODULES; do \
		printf "$(YELLOW)--- $(ENV)/$$module ---$(NC)\n"; \
		$(MAKE) --no-print-directory $(ENV)/$$module/output 2>/dev/null || printf "No outputs or not deployed\n"; \
		printf "\n"; \
	done
