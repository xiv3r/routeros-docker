#!make

ROUTEROS_VERSION := 7.19.5
TARGET := henriquesebastiao/routeros

all: build latest

build:
	docker buildx create --use
	docker buildx build --build-arg ROUTEROS_VERSION=$(ROUTEROS_VERSION) --platform=linux/amd64,linux/arm64 -t $(TARGET):$(ROUTEROS_VERSION) --push .

latest:
	docker buildx create --use
	docker buildx build --build-arg ROUTEROS_VERSION=$(ROUTEROS_VERSION) --platform=linux/amd64,linux/arm64 -t $(TARGET):latest --push .

lint:
	ruff check bin/generate-dhcpd-conf.py; ruff check bin/generate-dhcpd-conf.py --diff

format:
	ruff format bin/generate-dhcpd-conf.py; ruff check bin/generate-dhcpd-conf.py --fix

.PHONY: all build latest lint format