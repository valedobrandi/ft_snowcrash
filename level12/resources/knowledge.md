**CGI Perl Injection with Case and Whitespace Filters**

**What the service does**
A Perl CGI script runs on a local web server as the flag12 user. It takes two URL parameters, applies two filters to the first one, then passes it directly into a shell command via egrep using backticks. The two filters uppercase all lowercase letters and strip everything after the first whitespace. Despite these filters, command injection is still possible by working around both constraints.

**The exploit logic**
The injection point is the egrep call — the filtered input lands inside `egrep "^$xx"` which is executed by a real shell. By injecting `$(/*/CRACK)` as the parameter, the shell performs command substitution before egrep runs, executing whatever script is found at the glob path. The glob `/*/CRACK` expands to `/tmp/CRACK` automatically, meaning you never need to type the directory name directly.

The two filters are bypassed cleanly. The uppercase filter is irrelevant because the payload contains no lowercase letters — slashes, asterisks, dollar signs, and parentheses are unaffected by `tr/a-z/A-Z/`. The whitespace filter is irrelevant because the payload has no spaces. Both filters were designed to prevent obvious injection but failed to account for shell metacharacters and glob expansion.

**Why the script file needed to be uppercase**
The command you want to run — getflag — contains lowercase letters which would be uppercased to GETFLAG, a nonexistent command. Rather than fighting the filter, you sidestep it entirely by putting the real command inside a shell script with an already-uppercase name. The filter converts your input but `/tmp/CRACK` stays `/tmp/CRACK` since it has no lowercase letters to convert.

**Why the CGI runs as flag12**
Apache worker processes run as www-data, but the Perl script has the setuid bit set. While the kernel normally ignores setuid on interpreted scripts, in this environment Apache is configured to honour it via a suexec wrapper or equivalent mechanism, causing the CGI to execute as flag12 rather than www-data. This is confirmed by the whoami injection returning flag12.

**Why it happens**
The root cause is the same as every previous injection level — user input reaches a shell command without being treated as data. The filters gave a false sense of security by blocking the most obvious attacks like spaces and lowercase commands, but shell syntax is rich enough that there are always alternative paths. Filtering is inherently a losing strategy against shell injection because you are trying to blacklist dangerous characters in a context where almost any character can be dangerous.

**How to prevent it**
The egrep call should never receive raw user input. If the intent is to search a file, use a Perl native file reading and pattern matching approach that never touches a shell — open the file directly in Perl and apply the regex without spawning a subprocess. If a shell call is truly necessary, use a whitelist that only allows alphanumeric characters and nothing else, rejecting any input that contains shell metacharacters. Setuid on CGI scripts should be avoided entirely — privilege separation should be handled at the process level through dedicated privileged services with narrow interfaces, not by elevating web-facing scripts that handle untrusted input.