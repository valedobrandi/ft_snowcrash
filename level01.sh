#!/bin/bash

#token f2av5il02puano7naaf6adaaf

whoami
id
pwd
hostname

ls -la

cat /etc/passwd | grep flag

./hashcat.bin -m 1500 -a 3 flag01.txt '?l?l?l?l?l?l?l' --show
