#!/bin/bash

BASE_IMAGE=$1
DOCKER_FILE=$2
EXTRA_PACKAGES=$3
EXTRA_BUILD_ARGS=$4

echo BASE_IMAGE=$BASE_IMAGE
echo DOCKER_FILE=$DOCKER_FILE
echo EXTRA_PACKAGES=$EXTRA_PACKAGES
echo EXTRA_BUILD_ARGS=$EXTRA_BUILD_ARGS

set +e

echo "" && echo "Clean old images..."
docker image rm $BASE_IMAGE:amd64
docker image rm $BASE_IMAGE:arm64
echo "y" | docker builder prune

set -e

echo "" && echo "Build for amd64..."
docker buildx build --platform linux/amd64 --build-arg EXTRA_PACKAGES="$EXTRA_PACKAGES" --build-arg "$EXTRA_BUILD_ARGS" -t $BASE_IMAGE:amd64 -f $DOCKER_FILE .

echo "" && echo "Build for arm64..."
docker buildx build --platform linux/arm64 --build-arg EXTRA_PACKAGES="$EXTRA_PACKAGES" --build-arg "$EXTRA_BUILD_ARGS" -t $BASE_IMAGE:arm64 -f $DOCKER_FILE .

echo "" && echo "Push for arm64..."
docker push $BASE_IMAGE:arm64

echo "" && echo "Push for amd64..."
docker push $BASE_IMAGE:amd64

set +e

echo ""
echo "Clean manifest."
docker manifest rm $BASE_IMAGE:latest

set -e

echo "" && echo "Build manifest."
docker manifest create $BASE_IMAGE:latest $BASE_IMAGE:amd64 $BASE_IMAGE:arm64

echo "" && echo "Push manifest."
docker manifest push $BASE_IMAGE:latest
