**SnowCrash Level03 — PATH Hijacking via Setuid Binary**

**What the binary does**
The level03 binary is a setuid executable, meaning it runs with elevated privileges regardless of who launches it. Internally it calls system("/usr/bin/env echo Exploit me"). The important part is that it uses env to resolve the echo command rather than calling echo by its full path /bin/echo. This is the mistake that makes the exploit possible.

**What env actually does**
env is a Unix utility that runs a command in a modified environment. When you call env echo, it searches through every directory listed in the PATH environment variable from left to right, and executes the first file named echo it finds. Normally PATH points to system directories so it finds /bin/echo. But PATH is just an environment variable — any user can modify it.

**The exploit logic**
Since the binary uses env to find echo, and env respects the caller's PATH, you can create a fake executable named echo in a directory you control and put that directory at the front of PATH. When the setuid binary runs and calls env echo, env finds your fake echo first and executes it instead of the real one. Because the binary is setuid, your fake echo inherits those elevated privileges when it runs. So whatever your fake echo contains — in this case a call to getflag — executes with the privileges of the binary owner, not yours.

**Why it happens**
The root cause is the combination of two things: a setuid binary that calls a command by name rather than full path, and a Unix design where child processes inherit the parent's environment including PATH. The binary trusted the environment it was called from, which is a dangerous assumption when elevated privileges are involved. A setuid binary should never rely on the caller's environment to resolve commands.

**How to prevent it**
The simplest fix is to use the full absolute path to every command inside privileged binaries — call /bin/echo directly instead of relying on env to find it. A deeper fix is to sanitize or reset the environment at the start of any setuid binary, explicitly setting PATH to known safe system directories before executing anything. Some systems also use secure_path in sudo configuration for exactly this reason. The general principle is that privileged code should never trust anything inherited from an unprivileged caller — not PATH, not environment variables, not working directory.