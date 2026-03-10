**SnowCrash Level04 — CGI Command Injection**

**What the code does**
A Perl CGI script listens on a local web server. It takes a URL parameter called x and passes it directly into a shell command using backticks. In Perl, backticks execute their contents as a shell command, so the user input lands inside a live shell string with no filtering whatsoever.

**The exploit**
Because the input is interpolated into a shell string, you can inject shell syntax alongside it. Sending `$(getflag)` as the parameter value causes the shell to evaluate it as a command substitution — it runs getflag first and substitutes the output into the echo command. A semicolon works too: `;getflag` terminates the echo and starts a new command. The shell has no idea the input came from a user, it just sees what looks like a normal command string.

**Why the privileges are elevated**
The CGI script runs as the flag04 user on the web server process. When getflag is called from inside that process it inherits those privileges, so the flag is returned even though you are logged in as a lower-privileged user. Same principle as level03 — elevated process, untrusted input, arbitrary execution.

**Why it happens**
Three things combine: user input reaches a shell with no sanitization, Perl backticks invoke a real /bin/sh which understands all shell syntax including semicolons and substitutions, and the process has elevated privileges that make the access meaningful.

**How to prevent it**
Never pass user input into a shell string. In Perl the fix is to use the list form of system() instead of backticks — `system("echo", $y)` calls the program directly without invoking a shell, so semicolons and substitutions are treated as literal characters and not syntax. If a shell is unavoidable, whitelist exactly what input is allowed before it touches the command. Keep CGI processes running as low-privilege users so that even successful injection has limited impact.