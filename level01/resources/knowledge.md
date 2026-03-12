The Exploit
Two compounding weaknesses:
/etc/passwd world-readable with the hash exposed — on modern systems hashes are stored in /etc/shadow which is root-only
DES crypt is cryptographically broken — extremely fast to crack with modern GPUs, making brute force trivial for short passwords
rockyou.txt covers the vast majority of CTF passwords instantly