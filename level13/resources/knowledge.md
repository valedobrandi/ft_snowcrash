**GDB Register Manipulation to Bypass UID Check**

**What the binary does**
A compiled binary checks if the current user's UID matches a hardcoded value — 4242 (0x1092 in hex) — before granting access. If the UID doesn't match it exits. There is no way to actually be UID 4242 on this system, so the check can never pass legitimately. The vulnerability is that the check happens in userspace and can be intercepted with a debugger.

**How the UID check works at the assembly level**
The binary calls `getuid()` which returns the real UID of the running process. In 32-bit Intel architecture, when a function returns a value it always places it in the EAX register — that is just how the calling convention works. The very next instruction compares EAX against 0x1092. If they match, execution continues. If not, it exits. There is nothing cryptographic or protected about this — it is a plain integer comparison that happens to live in a register you can modify.

**The exploit logic**
GDB is a debugger that can pause execution at any point and modify CPU state directly. By setting a breakpoint immediately after the `getuid()` call returns — before the comparison instruction executes — you can overwrite the EAX register with 4242. When execution resumes, the comparison sees 4242 == 4242, the check passes, and the binary continues as if you were the privileged user. The binary never knew the difference because you intercepted the result in the CPU before the program had a chance to read it.

**Why this works**
The binary trusted the return value of getuid() blindly, with no secondary verification, no cryptographic check, no kernel-enforced gate. The entire security model was a single integer comparison in userspace. Userspace code is always fully visible and modifiable to a debugger running as the same user. Any check that can be bypassed by changing one register value is not a real security boundary.

**Why registers and not RAM**
Registers are the CPU's immediate working memory — tiny storage slots inside the processor itself used for active computation. RAM holds longer-term data. When getuid() finishes, the result lives in EAX for just a moment before the comparison reads it. GDB can freeze the CPU mid-execution and write directly to EAX before that read happens, which is faster and more surgical than patching the binary on disk.

**How to prevent it**
A UID check in userspace cannot be made truly secure because a debugger can always intercept it. Privilege checks that matter must happen in the kernel, not in the application. The correct approach is to use a setuid binary where the kernel enforces the privilege boundary, combined with actual authentication — a password, a token, a cryptographic proof — rather than just checking who you are. A check that can be defeated by changing one register is not a security mechanism, it is just an obstacle.