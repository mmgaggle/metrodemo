#!/bin/bash

set -ex

export IMGNAME="quay.io/mulbc/metro-demo"

podman build -t ${IMGNAME} . && podman push ${IMGNAME}