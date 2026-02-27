getfacl
cat
file
#it's a binary
# not stripped, function names and symbols are still inside the file

ltrace
strace
# PTRACE_SETOPTIONS: No such process

string

gdb

##
disassemble main
   0x08048595 <+9>:     call   0x8048380 <getuid@plt>
   # 4242 in hexadecimal 0x1092
   0x0804859a <+14>:    cmp    $0x1092,%eax)

break *main+31
run
info registers eax
    registers: CPU's current state, not the RAM.
    EAX is a specific "hand" (General Purpose Register) in 32-bit Intel processors.
    getuid() finishes, it always puts its result into the EAX register.

break *<ADRESS MEMORY>
set $eax = 4242
continue


2A31L79asukciNyi8uppkEuSx