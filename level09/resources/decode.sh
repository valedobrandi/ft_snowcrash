#!/bin/bash

ssh() {
    sshpass -p '25749xKZ8L7DkSCwJkT9dyv6f' ssh level09@localhost -p 2220 "$1"  
}

encrypt=$(ssh 'cat token')

echo "Encrypted password: $encrypt"

echo $encrypt > token

decrypted=$(python3 decrypt.py)

echo "Decrypted password: $decrypted"