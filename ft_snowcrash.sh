#!/bin/sh
qemu-system-x86_64 \
  -name vm \
  -m 8192 \
  -cpu host \
  -enable-kvm \
  -device virtio-gpu-pci \
  -nic user,model=virtio,hostfwd=tcp::8080-:80,hostfwd=tcp::2220-:4242 \
  -cdrom /sgoinfre/bde-albu/ISOs/SnowCrash.iso \
  -boot d
