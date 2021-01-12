DOCKER_REPO ?= namespace/repo
DOCKER_TAG  ?= latest
RAILS_ENV   ?= production

GIT_COMMIT = $(shell git rev-parse HEAD)

.PHONY: build image_push push

build:
	@docker build -t "$(DOCKER_REPO):$(DOCKER_TAG)" \
		--build-arg BUILD_COMMIT=$(GIT_COMMIT) \
		--build-arg RAILS_ENV=$(RAILS_ENV) \
		-f docker/Dockerfile .

define docker_push
docker push "$(DOCKER_REPO):$(DOCKER_TAG)"
endef

image_push:
	@$(docker_push)

push: build
	@$(docker_push)
