%:
	@true
.PHONY: apps
ARGS = $(filter-out $@, $(MAKECMDGOALS))

default: build

build:
	- docker-compose build

bash:
	- docker-compose run --rm exercism /bin/bash

iex:
	- iex -S mix

lint: credo

credo:
	mix credo
