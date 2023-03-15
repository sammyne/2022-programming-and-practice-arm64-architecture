#!/bin/bash

#repo_tag=sammyne/qemu:6.2.0-6213f46-aarch64-ubuntu20.04
#repo_tag=sammyne/arm64-tour:qemu-7.2.0-aarch64
repo_tag=sammyne/aarch64-tour:qemu-7.2.0-rs20230312-aarch64

docker run -it --rm     \
  -v $PWD:/workspaces   \
  -w /workspaces        \
  --entrypoint ""       \
  --name "aarch64-tour" \
  $repo_tag bash
