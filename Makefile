%:
	@true
.PHONY: apps
ARGS = $(filter-out $@, $(MAKECMDGOALS))

default: build

build:
	- docker-compose build

bash:
	- docker-compose run --rm sicp /bin/bash

iex:
	- iex -S mix

lint:
	- mix dialyzer

dialyzer-build-plt:
	- mix dialyzer --plt
