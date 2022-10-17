%:
	@true
.PHONY: apps
ARGS = $(filter-out $@, $(MAKECMDGOALS))

default: build

build:
	- docker-compose build

bash:
	- docker-compose run --rm sicp /bin/bash
