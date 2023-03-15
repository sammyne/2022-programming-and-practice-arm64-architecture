#!/bin/bash

repo_tag=sammyne/aarch64-tour:qemu-7.2.0-rs20230312-aarch64

docker run -it --rm     \
  -v $PWD:/workspaces   \
  -w /workspaces        \
  --entrypoint ""       \
  --name "aarch64-tour" \
  $repo_tag bash
