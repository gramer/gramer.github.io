TAG="\n\n\033[0;32m\#\#\# "
END=" \#\#\# \033[0m\n"

.PHONY: setup
jekyll-local: ## run jekyll-local
	@echo ${TAG}starting${END}
	@bundle exec jekyll serve
	@echo ${TAG}completed${END}

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


.DEFAULT_GOAL = help
