**PHP preg_replace /e Code Injection**

**What the vulnerability is**
PHP's `preg_replace` function had a modifier called `/e` that, after performing a regex substitution, would pass the result through `eval()` and execute it as PHP code. This means if user input reaches the replacement string, it becomes executable PHP. The `/e` flag was so dangerous it was deprecated in PHP 5.5 and removed entirely in PHP 7.

**Why the setuid binary matters**
The PHP script itself has no special privileges — the elevation comes from the compiled `level06` binary which has the setuid bit set and is owned by flag06. When you run the binary it temporarily becomes flag06, then internally calls the PHP script.

**The exploit logic**
The regex pattern `/(\[x (.*)\])/e` matches any input shaped like `[x SOMETHING]` and evaluates SOMETHING as PHP code. By crafting a payload that fits the pattern — `[x {${system("/bin/getflag")}}]` — the captured content gets passed to eval, which calls system() and executes getflag with flag06 privileges. The curly brace syntax forces PHP to evaluate the expression rather than treating it as a plain string.

**Why the quoting was so painful**
The payload contains characters that both local bash and remote bash want to interpret — dollar signs, curly braces, quotes. The cleanest solution was to write the payload locally with single quotes and pipe it via stdin into ssh, so neither shell ever had a chance to touch the contents before they hit the file.

**How to prevent it**
Never use `/e` — it conflates data and code in the most dangerous way possible. The modern replacement is `preg_replace_callback`, which takes a proper function to handle the replacement. The captured input is passed as data to that function, never evaluated. Beyond that, any script executed by a setuid binary should treat all file input as untrusted and validate it strictly before processing, since the elevated privileges make the blast radius much larger than a normal script.