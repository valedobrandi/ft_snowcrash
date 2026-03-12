**Lua Server Command Injection**

**What the service does**
A Lua script runs as a persistent TCP server on port 5151, listening for password attempts. When a client connects it reads one line of input, passes it into a shell command to compute its SHA1 hash, then compares the result against a hardcoded hash. The shell command is built by string concatenation: `echo YOURINPUT | sha1sum` — with no sanitization of the input.

**Why the setuid approach is different here**
Unlike previous levels where a setuid binary directly elevated privileges, here the Lua script cannot benefit from setuid because the kernel ignores the setuid bit on interpreted scripts. The elevation comes from the fact that the server process was launched by a privileged launcher and is already running as flag11. Any command executed by that process inherits flag11 privileges automatically — no setuid binary needed at runtime.

**The exploit logic**
Because the input is concatenated directly into a shell string passed to `io.popen`, injecting a semicolon breaks out of the echo command and appends an arbitrary second command. Sending `; /bin/getflag >> /tmp/f11` causes the server to execute `echo ; /bin/getflag >> /tmp/f11 | sha1sum` — the echo runs empty, getflag executes as flag11 and writes the token to a file, then sha1sum runs on nothing. The hash comparison fails and the server sends "Erf nope" back, but the file has already been written.

**Why timing mattered**
The injection executes inside the server process asynchronously. Reading the output file in the same ssh session failed because the server hadn't finished writing yet. Splitting into two ssh calls with a sleep between them gives the server process time to complete execution before the file is read. This is a common issue with blind injection — the result doesn't come back through the channel you're watching, so you need to account for execution time before checking the side channel.

**Why it happens**
Same root cause as level04 and level09 — string concatenation of untrusted input into a shell command. Lua's `io.popen` spawns a real shell to interpret the string, so all shell metacharacters including semicolons, pipes, and redirects are live syntax. The input was never treated as data, only as part of a command string.

**How to prevent it**
Never concatenate user input into shell commands. In Lua the safer approach is to use a native SHA1 library that never touches a shell, eliminating the injection surface entirely. If a shell call is unavoidable, the input must be strictly validated — for a password check, only alphanumeric characters should be accepted and anything else rejected before it reaches the command. Network-facing services that execute shell commands with elevated privileges are extremely high risk and should be treated with the same caution as any other privileged code execution path.