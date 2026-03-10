**Cron Job Directory Hijacking**

**What the server script does**
A shell script running as flag05 loops over every file in /opt/openarenaserver/, executes each one with bash, then deletes it. It is designed to look like a game server job processor — something that picks up and runs queued scripts automatically. The key detail is that it runs as flag05, meaning anything it executes inherits those elevated privileges.

**Why the directory is writable**
The ACL output shows that level05 has full rwx permissions on /opt/openarenaserver/. ACLs (Access Control Lists) extend the standard Unix permission model to grant specific users access beyond what the owner/group/other triplet allows. Root owns the directory, but level05 was explicitly granted write access — meaning you can drop files into it even though you don't own it.

**The exploit logic**
Since you can write to the directory and the flag05 process automatically executes everything it finds there, you simply drop a shell script containing getflag into the directory and wait. The cron job or daemon picks it up, runs it as flag05, and your script executes with elevated privileges. You poll /tmp/flag05 every few seconds until the output appears.

**Why it happens**
The script blindly executes every file dropped into a directory that an unprivileged user can write to. There is no validation of what the scripts contain, no checksum verification, no ownership check. Trust was granted to a location rather than to specific verified content. Combined with automatic privileged execution, any user with write access to that directory has indirect code execution as flag05.

**How to prevent it**
Never have a privileged process execute files from a directory writable by unprivileged users. If a job queue directory is necessary, it should be owned and writable only by the privileged user that processes it. Drop permissions should be handled through a controlled interface — a socket, a message queue, or a dedicated setuid binary that validates input — not a shared writable directory. At minimum, the script should verify file ownership before executing: only run files owned by root or the service user, never files placed there by arbitrary users.