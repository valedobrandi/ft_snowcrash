“exploit” is a race condition (specifically a TOCTOU bug: Time Of Check, Time Of Use) combined with a symlink attack.

access("...user_path...", R_OK)
open("...user_path...", O_RDONLY...)

Concept (TOCTOU + symlinks)
Many privileged programs do something like:

Check: “Is the user allowed to read this path?” (often via access() or permission checks on the pathname)
Use: “Now open/read the file at this path.” (via open() / fopen())
If there is a gap between (1) and (2), an attacker can change what the path points to after the check but before the open.

A symbolic link makes this easy because the pathname stays the same (e.g. /tmp/swap), but the target can be changed instantly to point somewhere else.

What swapper.sh is doing
It creates a path under tmp (/tmp/swap) that is repeatedly rewritten as a symlink:
sometimes pointing to a harmless readable file (/tmp/dummy)
sometimes pointing to the protected file (~/token)
In parallel, it repeatedly runs the vulnerable SUID program:
./level10 /tmp/swap 127.0.0.1
If level10 checks permissions when /tmp/swap points to the harmless file, the check passes.
If the symlink flips to ~/token right before the actual open/read, level10 may end up reading the token with its elevated privileges and sending it to the network destination (your nc listener).

That’s the whole idea: win the timing window at least once.

The program is treating a pathname as stable across multiple operations.
But a pathname in tmp is attacker-controlled; the symlink target can change between checks.
The program likely does check on path A → open path A later, assuming “A is still the same file”. It isn’t.

How to protect against it
In a privileged program:

Do not use access() for authorization before open() (common TOCTOU footgun).
Open first, then validate what you opened:
fd = open(path, ...)
fstat(fd, ...) and verify owner/mode, expected inode/device, etc.
Use open(..., O_NOFOLLOW) to refuse symlinks.
Prefer directory-FD based APIs: openat(dirfd, "file", ...) on a trusted directory, not attacker-controlled tmp.
Avoid using writable directories like tmp for security decisions; if you must, use safe patterns (mkstemp, fixed ownership, restrictive perms).
Drop privileges as early as possible (or avoid SUID entirely).
If you want, paste knowledge.md (or any notes you have on ltrace/strace), and I can map the explanation to the exact syscalls (access/open/read/write) you’re seeing.