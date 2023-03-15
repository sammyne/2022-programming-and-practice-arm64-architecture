#!/bin/bash

repo_tag=sammyne/aarch64-tour:qemu-7.2.0-rs20230312-aarch64

docker build -t $repo_tag .
