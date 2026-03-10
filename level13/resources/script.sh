#!/bin/bash

ssh() {
    sshpass -p 'g1qKMiRpXf53AWhDaU7FEkczr' ssh level13@localhost -p 2220 "$1"  
}

ssh "ls -la"

ssh "getfacl level13"

ssh 'file level13'

# not stripped
ssh 'ltrace ./level13'

ssh 'ltrace ./level13'

ssh 'strings level13'

ssh 'cat > /tmp/exploit.gdb << '"'"'EOF'"'"'
disassemble main

# Attach and set breakpoint after getuid() returns
break *main+14
run

# At this point getuid() has returned, EAX holds the real UID
# Overwrite EAX with 4242 (0x1092) before the comparison reads it
set $eax = 4242

# Resume execution, comparison now sees 4242 == 4242
continue
EOF

gdb -batch -x /tmp/exploit.gdb ./level13 2>/dev/null'

# your token is 2A31L79asukciNyi8uppkEuSx