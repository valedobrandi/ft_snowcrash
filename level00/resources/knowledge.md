The Exploit
Old Unix systems stored passwords directly in /etc/passwd using DES, which is a very weak 13-character hash
Credentials stored in a world-readable file, protected only by a weak classical cipher — trivially reversible once the encoding scheme is identified.

