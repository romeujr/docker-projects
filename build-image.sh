#!/bin/bash

BASE_IMAGE=$1
CURRENT_IMAGE=$2
DOCKER_FILE=$3
EXTRA_PACKAGES=$4
EXTRA_BUILD_ARGS=$5

echo BASE_IMAGE=$BASE_IMAGE
echo CURRENT_IMAGE=$CURRENT_IMAGE
echo DOCKER_FILE=$DOCKER_FILE
echo EXTRA_PACKAGES=$EXTRA_PACKAGES
echo EXTRA_BUILD_ARGS=$EXTRA_BUILD_ARGS

set +e

echo "" && echo "Clean old images..."
docker image rm $CURRENT_IMAGE:amd64
docker image rm $CURRENT_IMAGE:arm64
echo "y" | docker builder prune

set -e

echo "" && echo "Build for amd64..."
docker buildx build --platform linux/amd64 --build-arg BASE_IMAGE="$BASE_IMAGE":amd64 --build-arg EXTRA_PACKAGES="$EXTRA_PACKAGES" --build-arg "$EXTRA_BUILD_ARGS" -t $CURRENT_IMAGE:amd64 -f $DOCKER_FILE .

echo "" && echo "Build for arm64..."
docker buildx build --platform linux/arm64 --build-arg BASE_IMAGE="$BASE_IMAGE":arm64 --build-arg EXTRA_PACKAGES="$EXTRA_PACKAGES" --build-arg "$EXTRA_BUILD_ARGS" -t $CURRENT_IMAGE:arm64 -f $DOCKER_FILE .

echo "" && echo "Push for arm64..."
docker push $CURRENT_IMAGE:arm64

echo "" && echo "Push for amd64..."
docker push $CURRENT_IMAGE:amd64

set +e

echo ""
echo "Clean manifest."
docker manifest rm $CURRENT_IMAGE:latest

set -e

echo "" && echo "Build manifest."
docker manifest create $CURRENT_IMAGE:latest $CURRENT_IMAGE:amd64 $CURRENT_IMAGE:arm64

echo "" && echo "Push manifest."
docker manifest push $CURRENT_IMAGE:latest
