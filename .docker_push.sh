#!/bin/bash
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker push ${DOCKER_USERNAME}/vfx-lite
docker push ${DOCKER_USERNAME}/usd-lite
