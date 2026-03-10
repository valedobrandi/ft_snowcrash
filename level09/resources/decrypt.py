#!/usr/bin/env python3

import sys

with open("token", 'rb') as f:
    content = f.read().strip()

decoded = ""
for i, char_code in enumerate(content):
    decoded += chr(char_code - i)

print(decoded)
