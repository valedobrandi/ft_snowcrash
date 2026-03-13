#!/bin/bash

ssh() {
    sshpass -p 'x24ti5gi3x0ol2eh4esiuxias' ssh level01@localhost -p 2220 "$1"  
}

ssh "ls -la"

ssh "cat /etc/passwd | grep flag01"

#Hash Format 13-character string: 2 characters for salt + 11 for the hash.
encrypted=42hDRfypTqqnw

echo $encrypted > encrypted.txt

wget https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt

sleep 5

./hashcat-7.1.2/hashcat.bin -m 1500 -a 0 encrypted.txt ../resources/rockyou.txt

./hashcat-7.1.2/hashcat.bin -m 1500 -a 0 encrypted.txt ../resources/rockyou.txt --show

# sshpass -p "$decoded" ssh flag01@localhost -p 2220 "getflag" 

#Check flag.Here is your token : f2av5il02puano7naaf6adaaf

