The Exploit — Command Injection

In Perl, backticks execute a shell command and return its output.
`echo $y 2>&1`
Is a shell command substitution feature. It tells the shell to execute a command first and replace it with its output before running the rest of the command.
`$(command)` 