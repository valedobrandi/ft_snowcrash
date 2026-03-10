#!/bin/bash

ssh() {
    sshpass -p 'level00' ssh level00@localhost -p 2220 "$1"  
}

# Caesar cipher and ROT13 to crack the encoded password.

# Find files owned by user 'flag00' (potentially containing the password)
ssh "find / -user flag00 2>/dev/null"

# Read the encrypted password from the binary file.
encrypt=$(ssh "cat /usr/sbin/john")

echo "Encrypted password: $encrypt"


# Function: caesar_cipher
# Description: Applies a Caesar cipher shift to the input text.
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


# Function: rot13
# Description: Applies ROT13 (Caesar cipher with shift 13) to the input text.
rot13() {
	caesar_cipher "$1" 13
}


# Function: rot13_bruteforce
# Description: Tries all Caesar cipher shifts (1-25) to brute-force decode the text.
rot13_bruteforce() {
       local text="$1"
       for shift in {1..25}; do
	       result=$(caesar_cipher "$text" $shift)
	       echo "Shift $shift: $result"
       done
}


# Step 3: Apply Caesar cipher with shift 1 (as a first guess)
step1=$(caesar_cipher "$encrypt" 1)

# Step 4: Apply ROT13 to the result (common encoding in wargames)
step2=$(rot13 "$step1")

# Step 5: Brute-force all Caesar shifts on the result to find the correct password
rot13_bruteforce "$step2" 

sshpass -p "nottoohardhere" ssh flag00@localhost -p 2220 "getflag"
