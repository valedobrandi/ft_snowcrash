#!/bin/bash

ssh() {
    sshpass -p 'level00' ssh level00@localhost -p 2220 "$1"  
}

ssh "ls -la"

read pause

ssh "find / -user flag00 2>/dev/null"

read pause

echo 'cat /usr/sbin/john...'

read pause

ssh "cat /usr/sbin/john"

encrypt=$(ssh "cat /usr/sbin/john")

read pause

echo https://www.boxentriq.com/analysis/text-analysis
echo https://www.boxentriq.com/ciphers/caesar-cipher

caesar_cipher() {
       local text="$1"
       local shift=$2
       local output=""

       shift=$((shift%26))

       for (( i=0; i<${#text}; i++)); do
	       char="${text:$i:1}"
	       if [[ "$char" =~ [a-z] ]]; then
		       ascii=$(printf "%d" "'$char")
		       new=$(( (ascii - 97 + shift) % 26 + 97 ))
		       output+=$(printf "\\$(printf '%03o' "$new")")
	       elif [[ "$char" =~ [A-Z] ]]; then
		       ascii=$(printf "%d" "'$char")
		       new=$(( (ascii - 65 + shift) % 26 + 65 ))
		       output+=$(printf "\\$(printf '%03o' "$new")")
	       else
		       output+="$char"
	       fi
       done
       echo "$output"
}

rot13() {
	caesar_cipher "$1" 13
}

rot13_bruteforce() {
       local text="$1"
       for shift in {1..25}; do
	       result=$(caesar_cipher "$text" $shift)
	       echo "Shift $shift: $result"
       done
}

step1=$(caesar_cipher "$encrypt" 1)

step2=$(rot13 "$step1")

rot13_bruteforce "$step2" 

sshpass -p "nottoohardhere" ssh flag00@localhost -p 2220 "getflag"
