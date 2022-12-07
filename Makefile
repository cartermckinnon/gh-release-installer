MAKEFILE_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

# ensure that these flags are equivalent to the rules in the .editorconfig
SHFMT_FLAGS := --list \
--language-dialect auto \
--indent 2 \
--binary-next-line \
--case-indent \
--space-redirects

SHFMT_COMMAND := $(shell which shfmt)
ifeq (, $(SHFMT_COMMAND))
SHFMT_COMMAND = docker run --rm -v $(MAKEFILE_DIR):$(MAKEFILE_DIR) mvdan/shfmt
endif

.PHONY: fmt
fmt: ## Format the source files
	$(SHFMT_COMMAND) $(SHFMT_FLAGS) --write $(MAKEFILE_DIR)

SHELLCHECK_COMMAND := $(shell which shellcheck)
ifeq (, $(SHELLCHECK_COMMAND))
SHELLCHECK_COMMAND = docker run --rm -v $(MAKEFILE_DIR):$(MAKEFILE_DIR) koalaman/shellcheck:stable
endif
SHELL_FILES := $(shell find $(MAKEFILE_DIR) -type f -name '*.sh')

.PHONY: lint
lint: ## Check the source files for syntax and format issues
	$(SHFMT_COMMAND) $(SHFMT_FLAGS) --diff $(MAKEFILE_DIR)
	$(SHELLCHECK_COMMAND) --format gcc --severity error $(SHELL_FILES)