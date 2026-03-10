ssh() {
    sshpass -p '2A31L79asukciNyi8uppkEuSx' ssh level14@localhost -p 2220 "$1"  
}

ssh "ls -la"

ssh "find / -name getflag 2>/dev/null"

ssh "file /bin/getflag"

ssh 'strings /bin/getflag'

ssh 'strace /bin/getflag'

ssh 'cat > /tmp/exploit14.gdb << '"'"'EOF'"'"'

disassemble main

# getflag calls ptrace() on itself to detect debuggers.
# We break right after the test and force the jump to skip the exit.

break *0x08048990

# $pc is the Program Counter (also called EIP in 32-bit x86) 
# — it is the register that holds the address of the next instruction to execute.

commands
  set $pc = 0x080489a8
  continue
end

break *0x080489b6
commands
  set $pc = 0x080489ea
  continue
end

break *0x08048a00
commands
  set $pc = 0x08048a34
  continue
end

break *0x08048b0a
commands
  set $eax = 3006
  continue
end

run
EOF

gdb -batch -x /tmp/exploit14.gdb /bin/getflag 2>/dev/null'
