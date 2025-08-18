# Makefile Structure

This directory contains the modular Makefile structure for the Terraform management system.

## File Organization

```
Makefile              # Main Makefile with configuration and includes
makefiles/
├── terraform.mk      # Core Terraform operations and dynamic patterns
├── environment.mk    # Environment management (deploy/destroy environments)
├── utilities.mk      # Utility commands (format, validate, cleanup, discovery)
└── development.mk    # Development tools and quick deploy commands
```

## Module Responsibilities

### terraform.mk
- **Dynamic Pattern Rules**: Handles `<env>/<module>/<action>` patterns
- **Terraform Actions**: Core terraform commands (init, plan, apply, destroy, etc.)
- **Action Executor**: Internal `_terraform_action` function and `_execute_*` implementations

### environment.mk
- **Environment Operations**: Deploy, destroy, and show outputs for entire environments
- **Multi-Module Management**: Handles dependencies and ordering for environment-wide operations

### utilities.mk
- **Discovery Commands**: `list-envs`, `list-modules`, `state-list-all`
- **Format Commands**: `fmt`, `fmt-check` for Terraform code formatting
- **Validation Commands**: `validate-all` for configuration validation
- **Cleanup Commands**: `clean-all` for removing temporary files

### development.mk
- **Development Tools**: DevBox setup, environment checks
- **Quick Deploy**: Shortcuts for common development workflows
- **SSH Information**: Easy access to connection details
- **Examples**: Detailed usage examples

## Benefits of Modular Structure

1. **Maintainability**: Each file has a clear, focused responsibility
2. **Readability**: Smaller files are easier to understand and navigate
3. **Extensibility**: New functionality can be added by creating new modules
4. **Reusability**: Modules can be selectively included in different projects
5. **Testing**: Individual modules can be tested in isolation

## Adding New Functionality

To add new commands:

1. **Choose the Right Module**: Place commands in the most appropriate existing module
2. **Create New Module**: For entirely new functionality, create a new `.mk` file
3. **Update Main Makefile**: Add new modules to the `include` statements
4. **Update .PHONY**: Add new targets to the `.PHONY` declaration

## Migration Notes

- Original Makefile is backed up as `Makefile.backup`
- All functionality remains the same, just organized differently
- No changes to command syntax or behavior
- All dynamic patterns and commands work exactly as before
