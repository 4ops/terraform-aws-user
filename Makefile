.ONESHELL:
.SHELL := /usr/bin/bash
.PHONY: apply-test-plan backup clean commit ctrl-z fmt test-plan validate

export TF_IN_AUTOMATION=1
export TF_INPUT=0

fmt:
	@terraform fmt -recursive

validate: fmt
	@test -f secrets.env && . ./secrets.env || true
	@cd test
	@terraform init -backend=false -lock=false
	@terraform validate

test-plan: validate
	@test -f secrets.env && . ./secrets.env || true
	@cd test
	@terraform init
	@terraform plan -out=plan.tfplan

apply-test-plan:
	@test -f secrets.env && . ./secrets.env || true
	@cd test
	@terraform apply -refresh=false plan.tfplan
	@rm -f plan.tfplan

clean:
	@find . -depth -type d -a '(' \
		-name '.terraform' \
		-o \
		-name '*.backup' \
	')' -exec rm -rf '{}' +
	@find . -depth -type f -a '(' \
		-name '*.log' \
		-o \
		-name '*.tfstate' \
		-o \
		-name '*.tfstate.*' \
		-o \
		-name '*.tfplan' \
		-o \
		-name '*.backup' \
	')' -exec rm -rf '{}' +
