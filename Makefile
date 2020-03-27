AWS_VAULT_PROFILE=devops

default: validate 

all: validate check compliance terratest docs

check:
	@echo "Checking with Checkov..."
	@docker run -t -v ${PWD}:/tf bridgecrew/checkov -d /tf
	@echo "[OK] Checkov Checking Completed!"

compliance: plan 
	@echo "Checking Compliance..."
	@docker run --rm -v ${PWD}:/target -i -t \
		eerkunt/terraform-compliance -p plan.out -f test/compliance
	@rm -fv plan.out.json
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
	@rm -fv TERRAFORM_DOCS.md
	@echo "[OK] Terraform Docs Added to README.md"

fmt:
	@echo "Formatting Terraform..."
	@terraform fmt -recursive 
	@echo "[OK] Formatting Completed!"

lint:
	@echo "Linting Terraform..."
	@tflint
	@echo "Linting Terraform Examples..."
	@tflint ./examples
	@echo "[OK] Linting Completed!"

plan:
	@echo "Running Plan..."
	@aws-vault --debug exec $(AWS_VAULT_PROFILE) --no-session -- terraform plan -out plan.out
	@echo "[OK] Plan Completed!"

terratest:
	@echo "Running Tests..."
	@cd ./test; \
		aws-vault --debug exec $(AWS_VAULT_PROFILE) --no-session -- go test -v;\
		cd ../
	@echo "[OK] Tests Completed!"

validate: fmt lint
	@echo "Validating Terraform..."
	@terraform init 
	@terraform validate
	@echo "Validating Terraform Examples..."
	@terraform init ./examples
	@terraform validate ./examples
	@echo "[OK] Validation Completed!"

PHONY: all check compliance deep_lint docs fmt lint plan terratest validate 
