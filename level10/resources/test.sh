#!/bin/bash
echo "Testing level10 connectivity..." > /tmp/test

# capture what level10 sends
OUT=/tmp/level10_received
: > "$OUT"

nc -lk 6969 >"$OUT" &
NC_PID=$!

cleanup() {
  kill "$NC_PID" 2>/dev/null || true
}

trap cleanup EXIT
