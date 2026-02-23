#!/bin/bash

#token x24ti5gi3x0ol2eh4esiuxias

#find / -user flag00 2>/dev/null
#cat /usr/sbin/john

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

read -p "code: " input

step1=$(caesar_cipher "$input" 1)

step2=$(rot13 "$step1")

rot13_bruteforce "$step2"