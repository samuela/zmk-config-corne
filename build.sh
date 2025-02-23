#!/usr/bin/env nix-shell
#!nix-shell -i bash -p podman

set -ex

# Build the container in case it doesn't exist yet
podman build -t zmk-local .

# Run the build process in that container
podman run --rm -it \
  -v ${PWD}:/workspace \
  zmk-local \
  bash -c 'west build --pristine -b nice_nano_v2 -- -DSHIELD=corne_left -DZMK_CONFIG=/workspace/config -DZMK_EXTRA_MODULES=/tmp/zmk-helpers-${ZMK_HELPERS_COMMIT} && \
           mv build/zephyr/zmk.uf2 /workspace/corne_left_nice_nano_v2.uf2 && \
           west build --pristine -b nice_nano_v2 -- -DSHIELD=corne_right -DZMK_CONFIG=/workspace/config -DZMK_EXTRA_MODULES=/tmp/zmk-helpers-${ZMK_HELPERS_COMMIT} && \
           mv build/zephyr/zmk.uf2 /workspace/corne_right_nice_nano_v2.uf2'
