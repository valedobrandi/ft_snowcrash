#!/bin/bash

ssh() {
    sshpass -p '25749xKZ8L7DkSCwJkT9dyv6f' ssh level09@localhost -p 2220 "$1"  
}


ssh "ls -la"

ssh 'ltrace ./level09'
ssh 'strace ./level09'

ssh 'strings ./level09'

ssh './level09 aaaaa'

encrypt=$(ssh 'cat token')

echo "Encrypted password: $encrypt"

echo $encrypt > token

decrypted=$(python3 decrypt.py)

echo "Decrypted password: $decrypted"

sshpass -p "$decrypted" ssh flag09@localhost -p 2220 "getflag"  

# Check flag.Here is your token : s5cAJpM8ev6XHw998pRWG728z
