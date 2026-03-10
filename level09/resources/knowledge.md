
The SUID binary level09 expects one argument and applies a per-character transform (an “encryption”) to it.

For each character at position i, it outputs: out[i] = in[i] + i (ASCII shift that increases with the index).

in[i] = out[i] - i.
ex:.aaaa abcde
About the “anti-reversing” bits you saw

checks LD_PRELOAD, /etc/ld.so.preload
checks maps for injected libs
uses ptrace(PTRACE_TRACEME) as an anti-debug check