.PHONY: help ps build build-prod start fresh fresh-prod stop restart destroy \
	cache cache-clear migrate migrate migrate-fresh tests tests-html

CONTAINER_PHP=api
CONTAINER_REDIS=redis
CONTAINER_DATABASE=database

help:
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

auth:
    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 351091342598.dkr.ecr.us-east-1.amazonaws.com

build:
    docker build -t educarte-base-image .

push:
    docker tag educarte-base-image:latest 351091342598.dkr.ecr.us-east-1.amazonaws.com/educarte-base-image:latest
    docker push 351091342598.dkr.ecr.us-east-1.amazonaws.com/educarte-base-image:latest

