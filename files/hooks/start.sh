#!/bin/bash

# === Unload nvidia_drm

# Check if nvidia_drm is loaded and not in use
if lsmod | grep -q nvidia_drm; then
    # Try to unload it
    modprobe -r nvidia_drm || exit 1
fi