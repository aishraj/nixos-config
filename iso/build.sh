#!/usr/bin/env bash

set -euo pipefail
alias podman="podman"

function finish {
  set +e
  podman kill nixos-arm-builder > /dev/null
  podman rm nixos-arm-builder > /dev/null
}
trap finish EXIT

echo ""
echo "Building podman image"
podman build -t nixos-arm-builder .

echo ""
echo "Running podman container detached to copy file"
podman run --name nixos-arm-builder --detach nixos-arm-builder sleep 10m > /dev/null

echo ""
echo "Copying nixos.iso"
podman cp nixos-arm-builder:/tmp/nixos.iso .

echo ""
echo ""
echo "Copied iso to ./nixos.iso"
