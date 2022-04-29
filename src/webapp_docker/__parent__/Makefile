DOCKER_REGISTRY ?= registry.cn-shanghai.aliyuncs.com
DOCKER_REPO     ?= $(DOCKER_REGISTRY)/namespace/repo
DOCKER_TAG      ?= latest
CDN_HOST        ?= CDN_HOST_STUB

.PHONY: build image_push push

build:
	@docker build -t "$(DOCKER_REPO):$(DOCKER_TAG)" \
		--build-arg CDN_HOST=$(CDN_HOST) \
		-f docker/Dockerfile .

define docker_push
if test "$(DOCKER_USERNAME)" = "" ; then echo "DOCKER_USERNAME must be set"; exit 1; fi
if test "$(DOCKER_PASSWORD)" = "" ; then echo "DOCKER_PASSWORD must be set"; exit 1; fi
docker login -u "$(DOCKER_USERNAME)" -p "$(DOCKER_PASSWORD)" "$(DOCKER_REGISTRY)"
docker push "$(DOCKER_REPO):$(DOCKER_TAG)"
endef

image_push:
	@$(docker_push)

push: build
	@$(docker_push)

# Launch a container to run the image, which can be used as a smoke test.
# When launching, we bind mount `docker-entrypoint.sh`, so we can test it
# quickly when `docker-entrypoint.sh` is updated.
run:
	@echo The server will be listening at localhost:80
	@docker run --rm \
		-e NGINX_API_PROXY_ENABLED=true \
		--mount type=bind,source="$(PWD)/docker/docker-entrypoint.sh",target=/docker-entrypoint.sh \
		-p 80:80 "$(DOCKER_REPO):$(DOCKER_TAG)"
