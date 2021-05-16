SHELL:=/bin/bash

IMAGE_NAME=airflow_terraform
CONTAINER_NAME=airflow_terraform_1

.PHONY: build
build: ##@docker Build the docker container
	docker build . --tag $(IMAGE_NAME)

.PHONY: start
start: ##@docker Start daemon container with Terraform
	docker run \
		--rm \
		--detach \
		--volume ${PWD}/gcp:/root/gcp \
		--name $(CONTAINER_NAME)
		$(IMAGE_NAME)

.PHONY: shell
shell: ##@docker Calls shell CLI in the terraform container
	docker exec \
		--interactive \
		--tty \
		$(CONTAINER_NAME) \
		/bin/sh

.PHONY: gcloud
gcloud: ##@docker Calls gcloud auth login
	docker exec \
		--interactive \
		--tty \
		$(CONTAINER_NAME) \
		gcloud auth login --no-launch-browser --update-adc

.PHONY: stop
stop: ##@docker Stop and remove the container
	docker stop $(CONTAINER_NAME)
