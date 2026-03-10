**Environment Variable Injection**

**What the binary does**
The level07 binary is a setuid executable owned by flag07. It reads the LOGNAME environment variable using getenv(), then passes the value directly into a system() call without any sanitization, constructing a shell command that looks like `/bin/echo LOGNAME_VALUE`. Since system() invokes a real shell to execute the string, any shell syntax inside LOGNAME is interpreted as commands.

**The exploit logic**
By setting LOGNAME to `; getflag` before running the binary, the shell command becomes `/bin/echo ; getflag`. The semicolon terminates the echo and getflag executes as a separate command. Because the binary is setuid and owned by flag07, getflag runs in that elevated context and returns the token.

The critical detail is that the export and the binary execution must happen in the same shell session. Each separate ssh call spawns an independent shell that starts with a clean environment — any export from a previous call is gone. The fix is to set the variable inline on the same line as the binary: `LOGNAME="; getflag" ./level07`, which sets the variable only for that process without even needing export.

**Why it happens**
The binary trusted an environment variable as safe input. Environment variables are fully controlled by the calling user — they can contain any characters including shell metacharacters. Passing them into system() is identical in danger to passing unsanitized user input into a shell command. The pattern is the same as level03 and level04: privileged process plus unsanitized input plus shell execution equals arbitrary code execution.

**How to prevent it**
Never pass environment variables into shell commands without sanitization. Treat environment variables with the same suspicion as any other external input — they are user-controlled data. Use execve() or equivalent direct execution APIs that bypass the shell entirely, passing arguments as discrete values rather than a single interpreted string. If the value must be used in a shell context, validate it strictly against a whitelist before use. A general rule for setuid binaries is to sanitize or reset the entire environment at startup, keeping only variables that are explicitly needed and known safe.