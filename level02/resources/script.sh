#!/bin/bash
#token kooda2puivaav1idi4f57q8iq

ssh() {
    sshpass -p 'f2av5il02puano7naaf6adaaf' ssh level02@localhost -p 2220 "$1"  
}

ssh "tcpdump -nn -r level02.pcap -X"

ssh "tcpdump -nn -r level02.pcap -X | grep Passw"

ssh "ls -la"
pwd=$(ssh "pwd")

echo "Current directory: $pwd"

sshpass -p 'f2av5il02puano7naaf6adaaf' scp -P 2220 level02@localhost:$pwd/level02.pcap .

chmod +r level02.pcap

sleep 2

docker run --rm -it --network host \
    -v $(pwd)/level02.pcap:/net/level02.pcap \
    nicolaka/netshoot tshark -r /net/level02.pcap \
    -Y "tcp.len == 1 && ip.src == 59.233.235.218" \
    -T fields -e tcp.payload | python3 decode.py

sshpass -p 'ft_waNDReL0L' ssh flag02@localhost -p 2220 "getflag"

#Check flag.Here is your token : kooda2puivaav1idi4f57q8iq
