#!/bin/bash
set -e
BLOCK_NAME="support-toolkit"

function build_and_push_image () {
  local DOCKER_REPO=$1
  local BALENA_MACHINE_NAME=$2
  local DOCKER_ARCH=$3
  local BALENA_ARCH=$4

  echo "Building for machine name $BALENA_MACHINE_NAME, platform $DOCKER_ARCH, pushing to $DOCKER_REPO/$BLOCK_NAME"

  sed "s/%%BALENA_MACHINE_NAME%%/$BALENA_MACHINE_NAME/g" ./Dockerfile.template > ./Dockerfile.$BALENA_MACHINE_NAME
  sed -i.bak "s/%%BALENA_ARCH%%/$BALENA_ARCH/g" ./Dockerfile.$BALENA_MACHINE_NAME && rm ./Dockerfile.$BALENA_MACHINE_NAME.bak
  docker buildx build -t $DOCKER_REPO/$BLOCK_NAME:$BALENA_MACHINE_NAME --load --platform $DOCKER_ARCH --file Dockerfile.$BALENA_MACHINE_NAME .

  # No need to push to a local repository
  echo "Publishing..."
  docker push $DOCKER_REPO/$BLOCK_NAME:$BALENA_MACHINE_NAME

  echo "Cleaning up..."
  rm Dockerfile.$BALENA_MACHINE_NAME
}

# Commands include "--insecure" flag because we assume DOCKER_REPO refers to
# a registry on this workstation.
function create_and_push_manifest() {
  local DOCKER_REPO=$1
  docker manifest create $DOCKER_REPO/$BLOCK_NAME:latest \
    --amend $DOCKER_REPO/$BLOCK_NAME:genericx86-64-ext \
    #--amend $DOCKER_REPO/$BLOCK_NAME:raspberrypi4-64 \
    #--amend $DOCKER_REPO/$BLOCK_NAME:raspberrypi3

  docker manifest push --purge $DOCKER_REPO/$BLOCK_NAME:latest
}

# You can pass in a repo (such as a test docker repo) or accept the default
DOCKER_REPO=${1:-kb2ma}

build_and_push_image $DOCKER_REPO "genericx86-64-ext" "linux/amd64" "amd64"
#build_and_push_image $DOCKER_REPO "raspberrypi4-64" "linux/arm64" "aarch64"
#build_and_push_image $DOCKER_REPO "raspberrypi3" "linux/arm/v7" "armv7hf"
create_and_push_manifest $DOCKER_REPO
