# Terraform Core Operations
# Dynamic pattern rules and Terraform command execution

#########################
# Dynamic Pattern Rules #
#########################

# Pattern: environments/<env>/<module>/<action>
environments/%: 
	@$(MAKE) --no-print-directory _terraform_action ENV=$(word 2,$(subst /, ,$@)) MODULE=$(word 3,$(subst /, ,$@)) ACTION=$(word 4,$(subst /, ,$@))

# Pattern: <env>/<module>/<action> (shorthand)
%:
	@if [ "$(words $(subst /, ,$@))" = "3" ]; then \
		$(MAKE) --no-print-directory _terraform_action ENV=$(word 1,$(subst /, ,$@)) MODULE=$(word 2,$(subst /, ,$@)) ACTION=$(word 3,$(subst /, ,$@)); \
	else \
		printf "$(RED)Invalid format. Use: <env>/<module>/<action> or environments/<env>/<module>/<action>$(NC)\n"; \
		printf "Example: make dev/network/plan\n"; \
		exit 1; \
	fi

# Internal action executor
_terraform_action:
	@if [ -z "$(ENV)" ] || [ -z "$(MODULE)" ] || [ -z "$(ACTION)" ]; then \
		printf "$(RED)Error: ENV, MODULE, and ACTION must be specified$(NC)\n"; \
		exit 1; \
	fi
	@MODULE_DIR="$(INFRA_BASE_DIR)/environments/$(ENV)/$(MODULE)"; \
	if [ ! -d "$$MODULE_DIR" ]; then \
		printf "$(RED)Error: Directory $$MODULE_DIR does not exist$(NC)\n"; \
		printf "Available environments: $(ENVIRONMENTS)\n"; \
		if [ -n "$(ENV)" ]; then \
			printf "Available modules for $(ENV): $$(find $(INFRA_BASE_DIR)/environments/$(ENV) -mindepth 1 -maxdepth 1 -type d -exec basename {} \; 2>/dev/null | tr '\n' ' ')\n"; \
		fi; \
		exit 1; \
	fi; \
	COMMON_VARS="-var-file=\"../../common.tfvars\" -var-file=\"../common.tfvars\""; \
	printf "$(BLUE)Running terraform $(ACTION) for $(ENV)/$(MODULE)...$(NC)\n"; \
	cd "$$MODULE_DIR" && $(MAKE) --no-print-directory -f $(PROJECT_ROOT)/Makefile _execute_$(ACTION) COMMON_VARS="$$COMMON_VARS"
