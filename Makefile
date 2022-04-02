check: ## Check source code issues
	black --diff --check .
	isort --diff --check .
	bandit --recursive . --configfile pyproject.toml
	find . -iname "*.py" -not -path "./venv/*" | xargs pylint

fmt: ## Format code
	black .
	isort --atomic .

test: ## Run tests
	@coverage run --source="." manage.py test
	@coverage report

help: ## Show this help
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} { \
		if (/^[a-zA-Z_-]+:.*?##.*$$/) {printf "    %-20s%s\n", $$1, $$2} \
		else if (/^## .*$$/) {printf "  %s\n", substr($$1,4)} \
		}' $(MAKEFILE_LIST)