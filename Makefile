help: ## show help message
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n"} /^[$$()% a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

commit: tf-docs ## commits all code to git
	@git add -A && pre-commit run -a --config=.config/.pre-commit-config.yaml && cz c && git push

tf-docs: ## creates terraform documentation
	@terraform-docs -c .config/.terraform-docs.yaml terraform

tf-lint: ## lints terraform code
	@cd terraform && tflint

sec-scan: ## security scanning
	@checkov -d . -c .config/.checkov.yaml
