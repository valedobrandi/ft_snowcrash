#!/bin/bash

ssh() {
    sshpass -p 'x24ti5gi3x0ol2eh4esiuxias' ssh level01@localhost -p 2220 "$1"  
}

ssh "ls -la"

ssh "cat /etc/passwd | grep flag01"

encrypted=42hDRfypTqqnw

echo $encrypted > encrypted.txt

./hashcat-7.1.2/hashcat.bin -m 1500 -a 3 encrypted.txt '?l?l?l?l?l?l?l'

./hashcat-7.1.2/hashcat.bin -m 1500 -a 3 encrypted.txt '?l?l?l?l?l?l?l' --show | awk -F: '{print $NF}' | tee decoded.txt

decoded=$(cat decoded.txt)

echo "Decoded password: $decoded"

sshpass -p "$decoded" ssh flag01@localhost -p 2220 "getflag" 

#Check flag.Here is your token : f2av5il02puano7naaf6adaaf

