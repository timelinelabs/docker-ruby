MAKEFLAGS = '-e'
TAG := $(shell git rev-parse --abbrev-ref HEAD)
REPO := $(shell whoami)

.PHONY: build deploy

help:
	@echo "Available Targets:"
	@echo ""
	@echo "	build"
	@echo "	deploy"

build:
	docker build -t $(REPO)/ruby:$(TAG) .

deploy: build
	docker login quay.io
	docker tag $(REPO)/ruby:$(TAG) quay.io/timeline_labs/ruby:$(TAG)
	docker push quay.io/timeline_labs/ruby:$(TAG)