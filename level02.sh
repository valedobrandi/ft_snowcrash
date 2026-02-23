#!/bin/bash

#flag ft_waNDReL0L
#token kooda2puivaav1idi4f57q8iq

#app
apt install wireshark-common tshark

ls -la

tcpdump -nn -r level02.pcap -X

tcpdump -nn -r level02.pcap -X | grep Passw

tshark -r level02.pcap -Y "tcp.len == 1 && ip.src == 59.233.235.218" -T fields -e tcp.payload

