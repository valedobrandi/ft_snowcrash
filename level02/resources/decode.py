import sys
output = []
for h in sys.stdin:
    byte = int(h, 16)
    if byte == 0x7f:
        char = "DEL"
        if output: output.pop()
    elif byte == 0x0d:
        char = "CR"
    else:
        char = chr(byte)
        output.append(char)
    print(f"0x{h} = {char:4}  →  {''.join(output)}")

print("\nFinal password:", ''.join(output))