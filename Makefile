AWS_VAULT_PROFILE=devops

default: validate 

all: validate check compliance docs

check:
	@echo "Checking with Checkov..."
	@docker run -t -v ${PWD}:/tf bridgecrew/checkov -d /tf
	@echo "[OK] Checkov Checking Completed!"

compliance: plan 
	@echo "Checking Compliance..."
	@docker run --rm -v ${PWD}:/target -i -t \
		eerkunt/terraform-compliance -p plan.out -f test/compliance
	@rm -f plan.out.json
	@echo "[OK] Compliance Checking Completed!"

deep_lint:
	@echo "Deep Linting Terraform..."
	@aws-vault --debug exec $(AWS_VAULT_PROFILE) -- tflint --deep
	@echo "[OK] Deep Linting Completed!"

docs:
	@echo "Generating Docs and Adding to README.md..."
	@terraform-docs markdown table . > TERRAFORM_DOCS.md
	@sed -e '/((TERRAFORM_DOCS))/{r TERRAFORM_DOCS.md' -e 'd}' \
	      README_TEMPLATE.md > README.md
	@rm TERRAFORM_DOCS.md
	@echo "[OK] Terraform Docs Added to README.md"

fmt:
	@echo "Formatting Terraform..."
	@terraform fmt
	@echo "[OK] Formatting Completed!"

lint:
	@echo "Linting Terraform..."
	@tflint
	@echo "[OK] Linting Completed!"

plan:
	@echo "Running Plan..."
	@aws-vault --debug exec $(AWS_VAULT_PROFILE) -- terraform plan -out plan.out
	@echo "[OK] Plan Completed!"

validate: fmt lint
	@echo "Validating Terraform..."
	@terraform validate
	@echo "[OK] Validation Completed!"

PHONY: all check compliance deep_lint docs fmt lint plan validate 
