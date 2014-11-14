TAG := $(shell git rev-parse --abbrev-ref HEAD)
USER := $(shell whoami)

.PHONY: build deploy

help:
	@echo "Available Targets:"
	@echo ""
	@echo "	build"
	@echo "	deploy"

build:
	docker build -t $(USER)/ruby:$(TAG) .

deploy: build
	docker login quay.io
	docker tag $(USER)/ruby:$(TAG) quay.io/timeline_labs/ruby:$(TAG)
	docker push quay.io/timeline_labs/ruby:$(TAG)