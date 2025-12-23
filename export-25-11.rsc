# 2025-11-20 12:05:09 by RouterOS 7.20.4
# software id = 1EJN-J58B
#
# model = CCR2004-16G-2S+
# serial number = HFH09AB87MW
/interface bridge
add name=bridge port-cost-mode=short vlan-filtering=yes
add admin-mac=0E:0B:CC:DE:73:66 auto-mac=no name=bridge1
/interface ethernet
set [ find default-name=ether1 ] mac-address=78:9A:18:E4:DD:42
set [ find default-name=ether2 ] mac-address=78:9A:18:E4:DD:43
set [ find default-name=ether3 ] mac-address=78:9A:18:E4:DD:44
set [ find default-name=ether4 ] mac-address=78:9A:18:E4:DD:45
set [ find default-name=ether5 ] mac-address=78:9A:18:E4:DD:46
set [ find default-name=ether6 ] mac-address=78:9A:18:E4:DD:47
set [ find default-name=ether7 ] mac-address=78:9A:18:E4:DD:48
set [ find default-name=ether8 ] mac-address=78:9A:18:E4:DD:49
set [ find default-name=ether9 ] mac-address=78:9A:18:E4:DD:4A
set [ find default-name=ether10 ] mac-address=78:9A:18:E4:DD:4B
set [ find default-name=ether11 ] mac-address=78:9A:18:E4:DD:4C
set [ find default-name=ether12 ] mac-address=78:9A:18:E4:DD:4D
set [ find default-name=ether13 ] mac-address=78:9A:18:E4:DD:4E
set [ find default-name=ether14 ] mac-address=78:9A:18:E4:DD:4F
set [ find default-name=ether15 ] mac-address=78:9A:18:E4:DD:50
set [ find default-name=ether16 ] disabled=yes mac-address=78:9A:18:E4:DD:51
set [ find default-name=sfp-sfpplus1 ] mac-address=78:9A:18:E4:DD:53
set [ find default-name=sfp-sfpplus2 ] mac-address=78:9A:18:E4:DD:52
/interface vlan
add interface=bridge name=vlan-100-mngmnt vlan-id=100
add interface=bridge name=vlan-101-it vlan-id=101
add interface=bridge name=vlan-102-lan vlan-id=102
add interface=bridge name=vlan-104-guest vlan-id=104
add interface=bridge name=vlan-106-print vlan-id=106
add interface=bridge name=vlan-107-cctv vlan-id=107
add interface=bridge name=vlan-110-it vlan-id=110
add interface=bridge name=vlan-111-buh vlan-id=111
add interface=bridge name=vlan-112-pam vlan-id=112
add interface=bridge1 name=vlan1 vlan-id=430
add interface=bridge1 name=vlan2 vlan-id=431
/interface list
add name=WAN
add name=LAN
add name=VLAN_to_INET
add name=VLAN
add name=VLAN_to_8
add name=INTERNET
add name=VLAN_INPUT
/ip ipsec policy group
add name=group14
/ip ipsec profile
set [ find default=yes ] dpd-interval=2m dpd-maximum-failures=5
add dh-group=modp2048 dpd-interval=45s enc-algorithm=aes-256 hash-algorithm=\
    sha256 lifetime=1h name=Azure_IPsec_phase1 nat-traversal=no
add dh-group=modp4096 enc-algorithm=aes-256 hash-algorithm=sha512 lifetime=8h \
    name=palo-alto
/ip ipsec peer
add address=20.215.248.98/32 disabled=yes exchange-mode=ike2 name=palo-alto \
    profile=palo-alto
add address=20.56.66.54/32 disabled=yes exchange-mode=ike2 local-address=\
    95.67.32.90 name=Azure profile=Azure_IPsec_phase1
/ip ipsec proposal
set [ find default=yes ] disabled=yes
add auth-algorithms=sha256 enc-algorithms=aes-256-cbc lifetime=1h name=\
    Azure_phase2 pfs-group=modp2048
add auth-algorithms="" enc-algorithms=aes-256-gcm lifetime=1h name=\
    palo-crypto-profile pfs-group=modp4096
/ip pool
add name=dhcp_pool1 ranges=192.168.0.20-192.168.0.254
add name=dhcp_pool2 ranges=172.16.0.20-172.16.0.150
add name=dhcp_pool3 ranges=172.16.1.20-172.16.1.200
add name=dhcp_pool4 ranges=172.16.2.10-172.16.3.50
add name=dhcp_pool5 ranges=172.16.4.10-172.16.5.120
add name=dhcp_pool6 ranges=172.16.6.20-172.16.6.250
add name=dhcp_pool7 ranges=172.17.1.5-172.17.1.125
add name=dhcp_pool8 ranges=172.16.10.8-172.16.10.120
add name=dhcp_pool9 ranges=172.16.11.5-172.16.11.150
add name=dhcp_pool10 ranges=172.16.12.20-172.16.12.150
add name=dhcp_pool11 ranges=172.25.20.2-172.25.20.6
/ip dhcp-server
add address-pool=dhcp_pool2 interface=vlan-100-mngmnt lease-time=3d name=\
    dhcp-100-mng
add address-pool=dhcp_pool4 interface=vlan-102-lan lease-time=10h name=\
    dhcp-102-lan
add address-pool=dhcp_pool5 interface=vlan-104-guest lease-time=4h name=\
    dhcp-104-guest
add address-pool=dhcp_pool6 interface=vlan-106-print lease-time=3d name=\
    dhcp-106-print
add address-pool=dhcp_pool7 interface=vlan-107-cctv lease-time=3d name=\
    dhcp-107-cctv
add add-arp=yes address-pool=dhcp_pool8 interface=vlan-110-it lease-time=10h \
    name=dhcp-110-it
add address-pool=dhcp_pool9 interface=vlan-111-buh lease-time=1d name=\
    dhcp-111-buh
add address-pool=dhcp_pool10 interface=vlan-112-pam lease-time=1d name=\
    dhcp-112-pam
add address-pool=dhcp_pool1 interface=bridge name=dhcp-1-bridge
/port
set 0 name=serial0
/queue simple
add dst=sfp-sfpplus2 max-limit=600M/600M name=Main-ISP1 target=""
add dst=sfp-sfpplus2 max-limit=200M/200M name=Main-ISP2 target=""
/queue type
add kind=fq-codel name=FQ_Codel
add cake-flowmode=dual-srchost cake-memlimit=32.0MiB cake-nat=yes \
    cake-rtt-scheme=internet kind=cake name=cake-upload
add cake-flowmode=dual-dsthost cake-memlimit=32.0MiB cake-nat=yes \
    cake-rtt-scheme=internet kind=cake name=cake-download
set 8 pcq-classifier=src-address,src-port pcq-total-limit=8000KiB
set 9 pcq-classifier=dst-address,dst-port pcq-total-limit=8000KiB
/queue simple
add comment=new-web limit-at=100M/100M max-limit=600M/600M name=Web parent=\
    Main-ISP1 priority=3/3 queue=cake-upload/cake-download target=\
    172.16.10.0/24,172.16.11.0/24,172.16.12.0/24,172.16.2.0/23
add limit-at=50M/50M max-limit=250M/250M name=Other parent=Main-ISP1 \
    priority=6/6 queue=cake-upload/cake-download target=\
    172.16.10.0/24,172.16.11.0/24,172.16.12.0/24,172.16.2.0/23
add limit-at=5M/5M max-limit=300M/300M name=Guest parent=Main-ISP1 queue=\
    cake-upload/cake-download target=172.16.4.0/23
/system logging action
add name=Syslog remote=10.10.10.9 remote-log-format=syslog src-address=\
    172.16.0.1 syslog-facility=local0 syslog-severity=info \
    syslog-time-format=iso8601 target=remote
/interface bridge port
add bridge=bridge interface=ether2 internal-path-cost=10 path-cost=10 pvid=\
    100
add bridge=bridge interface=ether3 internal-path-cost=10 path-cost=10
add bridge=bridge interface=ether4 internal-path-cost=10 path-cost=10
add bridge=bridge interface=ether5 internal-path-cost=10 path-cost=10
add bridge=bridge interface=ether6 internal-path-cost=10 path-cost=10
add bridge=bridge interface=ether7 internal-path-cost=10 path-cost=10
add bridge=bridge interface=ether8 internal-path-cost=10 path-cost=10
add bridge=bridge interface=ether9 internal-path-cost=10 path-cost=10
add bridge=bridge interface=ether10 internal-path-cost=10 path-cost=10
add bridge=bridge interface=ether11 internal-path-cost=10 path-cost=10
add bridge=bridge interface=ether12 internal-path-cost=10 path-cost=10
add bridge=bridge interface=ether13 internal-path-cost=10 path-cost=10
add bridge=bridge interface=ether14 internal-path-cost=10 path-cost=10
add bridge=bridge interface=ether16 internal-path-cost=10 path-cost=10
/ipv6 settings
set disable-ipv6=yes
/interface bridge vlan
add bridge=bridge tagged=ether16,bridge untagged=ether2 vlan-ids=100
add bridge=bridge tagged=ether16,bridge vlan-ids=101
add bridge=bridge tagged=ether16,bridge vlan-ids=102
add bridge=bridge tagged=ether16,bridge vlan-ids=104
add bridge=bridge tagged=ether16,bridge vlan-ids=106
add bridge=bridge tagged=ether16,bridge vlan-ids=107
add bridge=bridge tagged=ether16,bridge vlan-ids=110
add bridge=bridge tagged=ether16,bridge vlan-ids=111
add bridge=bridge tagged=ether16,bridge vlan-ids=112
add bridge=bridge tagged=ether16,bridge vlan-ids=200
/interface list member
add disabled=yes interface=vlan-100-mngmnt list=VLAN_to_INET
add disabled=yes interface=vlan-101-it list=VLAN_to_INET
add disabled=yes interface=vlan-102-lan list=VLAN_to_INET
add disabled=yes interface=vlan-104-guest list=VLAN_to_INET
add disabled=yes interface=vlan-106-print list=VLAN_to_INET
add interface=sfp-sfpplus1 list=WAN
add interface=sfp-sfpplus2 list=WAN
add interface=bridge list=VLAN_to_INET
add interface=vlan-107-cctv list=VLAN_INPUT
add interface=vlan-102-lan list=VLAN_to_INET
add interface=vlan-100-mngmnt list=VLAN_to_INET
add interface=vlan-101-it list=VLAN_to_INET
add interface=vlan-104-guest list=VLAN_to_INET
add interface=vlan-106-print list=VLAN_to_INET
add interface=vlan-110-it list=VLAN_to_INET
/ip address
add address=192.168.88.1/24 comment=defconf interface=ether15 network=\
    192.168.88.0
add address=95.67.32.90/29 interface=sfp-sfpplus2 network=95.67.32.88
add address=192.168.0.1/24 comment=VLAN1-printers interface=bridge network=\
    192.168.0.0
add address=172.16.0.1/24 interface=vlan-100-mngmnt network=172.16.0.0
add address=172.16.2.1/23 interface=vlan-102-lan network=172.16.2.0
add address=172.16.4.1/23 interface=vlan-104-guest network=172.16.4.0
add address=172.16.6.1/24 interface=vlan-106-print network=172.16.6.0
add address=172.17.1.1/24 interface=vlan-107-cctv network=172.17.1.0
add address=172.16.10.1/24 comment=vlan-it interface=vlan-110-it network=\
    172.16.10.0
add address=172.16.11.1/24 comment=vlan-buh interface=vlan-111-buh network=\
    172.16.11.0
add address=172.16.12.1/24 comment=vlan-buh interface=vlan-112-pam network=\
    172.16.12.0
add address=95.67.32.92/29 disabled=yes interface=sfp-sfpplus2 network=\
    95.67.32.88
add address=95.67.32.94/29 interface=sfp-sfpplus2 network=95.67.32.88
/ip dhcp-server lease
add address=172.16.0.22 client-id=1:44:12:44:c4:3e:56 mac-address=\
    44:12:44:C4:3E:56 server=dhcp-100-mng
add address=172.16.0.23 client-id=1:44:12:44:c4:51:da mac-address=\
    44:12:44:C4:51:DA server=dhcp-100-mng
add address=172.16.0.24 client-id=1:44:12:44:c4:45:8c mac-address=\
    44:12:44:C4:45:8C server=dhcp-100-mng
add address=172.16.0.25 client-id=1:20:9c:b4:c4:46:98 mac-address=\
    20:9C:B4:C4:46:98 server=dhcp-100-mng
add address=172.16.0.26 client-id=1:20:9c:b4:c4:36:9e mac-address=\
    20:9C:B4:C4:36:9E server=dhcp-100-mng
add address=172.16.0.27 client-id=1:20:9c:b4:c4:7c:b4 mac-address=\
    20:9C:B4:C4:7C:B4 server=dhcp-100-mng
add address=172.16.0.28 client-id=1:20:9c:b4:c4:89:40 mac-address=\
    20:9C:B4:C4:89:40 server=dhcp-100-mng
add address=172.16.0.21 client-id=1:20:9c:b4:c4:71:98 mac-address=\
    20:9C:B4:C4:71:98 server=dhcp-100-mng
add address=172.16.0.29 client-id=1:20:9c:b4:c4:82:40 mac-address=\
    20:9C:B4:C4:82:40 server=dhcp-100-mng
add address=172.16.0.30 client-id=1:a0:25:d7:c6:24:a0 mac-address=\
    A0:25:D7:C6:24:A0 server=dhcp-100-mng
add address=172.17.1.124 client-id=1:c4:79:5:81:f5:9f mac-address=\
    C4:79:05:81:F5:9F server=dhcp-107-cctv
add address=172.17.1.123 client-id=1:c4:79:5:81:f6:10 mac-address=\
    C4:79:05:81:F6:10 server=dhcp-107-cctv
add address=172.17.1.122 client-id=1:c4:79:5:81:f6:e mac-address=\
    C4:79:05:81:F6:0E server=dhcp-107-cctv
add address=172.17.1.121 client-id=1:c4:79:5:81:f5:a0 mac-address=\
    C4:79:05:81:F5:A0 server=dhcp-107-cctv
add address=172.17.1.120 client-id=1:c4:79:5:81:f5:89 mac-address=\
    C4:79:05:81:F5:89 server=dhcp-107-cctv
add address=172.17.1.119 client-id=1:c4:79:5:82:c:b9 mac-address=\
    C4:79:05:82:0C:B9 server=dhcp-107-cctv
add address=172.17.1.118 client-id=1:34:e6:d7:1e:f6:43 mac-address=\
    34:E6:D7:1E:F6:43 server=dhcp-107-cctv
add address=172.17.1.117 client-id=1:c4:79:5:82:c:b8 disabled=yes \
    mac-address=C4:79:05:82:0C:B8 server=dhcp-107-cctv
add address=172.17.1.116 client-id=1:90:e9:5e:b0:ab:ef disabled=yes \
    mac-address=90:E9:5E:B0:AB:EF server=dhcp-107-cctv
add address=172.17.1.115 client-id=1:c4:79:5:81:f6:11 mac-address=\
    C4:79:05:81:F6:11 server=dhcp-107-cctv
add address=172.17.1.114 client-id=1:c4:79:5:81:f6:18 mac-address=\
    C4:79:05:81:F6:18 server=dhcp-107-cctv
add address=172.17.1.113 client-id=1:c4:79:5:81:f5:ba mac-address=\
    C4:79:05:81:F5:BA server=dhcp-107-cctv
add address=172.17.1.111 client-id=1:c4:79:5:81:f5:dc mac-address=\
    C4:79:05:81:F5:DC server=dhcp-107-cctv
add address=172.16.2.150 client-id=1:e8:80:88:fa:b3:72 mac-address=\
    E8:80:88:FA:B3:72 server=dhcp-102-lan
add address=172.16.0.31 client-id=1:44:12:44:c4:56:1a mac-address=\
    44:12:44:C4:56:1A server=dhcp-100-mng
add address=172.16.0.32 client-id=1:20:9c:b4:c4:6d:e0 mac-address=\
    20:9C:B4:C4:6D:E0 server=dhcp-100-mng
add address=172.16.0.33 client-id=1:b8:37:b2:c5:be:ea mac-address=\
    B8:37:B2:C5:BE:EA server=dhcp-100-mng
add address=172.16.0.34 client-id=1:20:9c:b4:c4:6d:6a mac-address=\
    20:9C:B4:C4:6D:6A server=dhcp-100-mng
add address=172.16.6.250 comment=Yur-8 mac-address=6C:3C:7C:F4:30:2F server=\
    dhcp-106-print
add address=172.16.6.249 client-id=1:6c:3c:7c:f4:31:fe comment=Buh-8 \
    mac-address=6C:3C:7C:F4:31:FE server=dhcp-106-print
add address=172.16.6.248 client-id=1:74:bf:c0:ff:a5:42 comment=ALL-8 \
    mac-address=74:BF:C0:FF:A5:42 server=dhcp-106-print
add address=172.16.6.247 comment=ALL-4 disabled=yes mac-address=\
    40:F8:DF:6F:84:64 server=dhcp-106-print
add address=172.16.6.246 client-id=1:6c:3c:7c:f4:2c:f7 mac-address=\
    6C:3C:7C:F4:2C:F7 server=dhcp-106-print
add address=172.16.6.245 comment=4-floor mac-address=6C:3C:7C:F4:30:2B \
    server=dhcp-106-print
add address=172.16.2.128 client-id=1:a0:a4:c5:26:e4:a9 mac-address=\
    A0:A4:C5:26:E4:A9 server=dhcp-102-lan
add address=172.16.2.156 client-id=1:5c:e9:1e:c2:37:b0 comment=Serhii \
    mac-address=5C:E9:1E:C2:37:B0 server=dhcp-102-lan
add address=172.16.6.244 mac-address=00:02:32:53:9D:88 server=dhcp-106-print
add address=172.17.1.108 mac-address=44:B7:D0:84:8E:29 server=dhcp-107-cctv
add address=172.17.1.107 mac-address=E8:EB:1B:E4:62:E4 server=dhcp-107-cctv
add address=172.17.1.106 mac-address=E8:EB:1B:E4:62:6A server=dhcp-107-cctv
add address=172.17.1.105 mac-address=E8:EB:1B:E4:3E:AF server=dhcp-107-cctv
add address=172.17.1.110 client-id=1:40:c2:ba:da:7d:74 comment=\
    "CCTV SERVER PC" mac-address=40:C2:BA:DA:7D:74 server=dhcp-107-cctv
add address=172.16.6.243 client-id=1:40:f8:df:90:40:15 mac-address=\
    40:F8:DF:90:40:15 server=dhcp-106-print
add address=172.16.6.242 client-id=1:40:f8:df:6f:77:25 mac-address=\
    40:F8:DF:6F:77:25 server=dhcp-106-print
add address=172.16.6.247 client-id=1:40:f8:df:6f:84:64 mac-address=\
    40:F8:DF:6F:84:64 server=dhcp-106-print
add address=172.16.0.13 client-id=1:90:e9:5e:ab:63:4c mac-address=\
    90:E9:5E:AB:63:4C server=dhcp-100-mng
add address=172.16.0.20 client-id=1:94:64:24:cd:28:c0 mac-address=\
    94:64:24:CD:28:C0 server=dhcp-100-mng
add address=172.16.0.35 client-id=1:48:2f:6b:cd:1c:9c mac-address=\
    48:2F:6B:CD:1C:9C server=dhcp-100-mng
add address=172.16.0.14 mac-address=A0:A0:01:39:19:C0 server=dhcp-100-mng
add address=172.16.0.36 client-id=1:20:9c:b4:c4:27:44 mac-address=\
    20:9C:B4:C4:27:44 server=dhcp-100-mng
add address=172.16.0.37 client-id=1:20:9c:b4:c4:1f:2e mac-address=\
    20:9C:B4:C4:1F:2E server=dhcp-100-mng
add address=172.16.0.38 client-id=1:84:5a:3e:59:6e:58 mac-address=\
    84:5A:3E:59:6E:58 server=dhcp-100-mng
add address=172.16.0.39 client-id=1:48:2f:6b:c4:88:62 mac-address=\
    48:2F:6B:C4:88:62 server=dhcp-100-mng
add address=172.16.0.40 client-id=1:60:26:ef:ce:34:46 mac-address=\
    60:26:EF:CE:34:46 server=dhcp-100-mng
add address=172.16.0.41 client-id=1:60:26:ef:ce:56:48 mac-address=\
    60:26:EF:CE:56:48 server=dhcp-100-mng
add address=172.16.0.42 client-id=1:94:64:24:cd:2a:cc mac-address=\
    94:64:24:CD:2A:CC server=dhcp-100-mng
add address=172.16.0.43 client-id=1:94:64:24:cd:28:b2 mac-address=\
    94:64:24:CD:28:B2 server=dhcp-100-mng
add address=192.168.0.96 client-id=1:40:f8:df:74:9c:40 mac-address=\
    40:F8:DF:74:9C:40 server=dhcp-1-bridge
add address=192.168.0.94 client-id=1:6c:3c:7c:f4:30:2f mac-address=\
    6C:3C:7C:F4:30:2F server=dhcp-1-bridge
add address=192.168.0.249 mac-address=40:F8:DF:6E:D2:EF server=dhcp-1-bridge
add address=192.168.0.17 mac-address=40:F8:DF:74:9E:3D server=dhcp-1-bridge
add address=192.168.0.99 mac-address=6C:3C:7C:F4:30:25 server=dhcp-1-bridge
add address=192.168.0.92 client-id=1:40:f8:df:90:40:14 mac-address=\
    40:F8:DF:90:40:14 server=dhcp-1-bridge
add address=192.168.0.91 client-id=1:40:f8:df:90:40:15 mac-address=\
    40:F8:DF:90:40:15 server=dhcp-1-bridge
add address=192.168.0.76 client-id=1:9c:75:6e:16:c9:6d mac-address=\
    9C:75:6E:16:C9:6D server=dhcp-1-bridge
add address=172.16.6.20 client-id=1:40:f8:df:74:9c:40 mac-address=\
    40:F8:DF:74:9C:40 server=dhcp-106-print
add address=172.16.6.21 client-id=1:40:f8:df:6f:78:18 mac-address=\
    40:F8:DF:6F:78:18 server=dhcp-106-print
add address=172.16.0.47 client-id=1:94:64:24:cc:dd:78 mac-address=\
    94:64:24:CC:DD:78 server=dhcp-100-mng
add address=172.16.6.22 client-id=1:dc:c2:c9:5c:d1:da mac-address=\
    DC:C2:C9:5C:D1:DA server=dhcp-106-print
add address=172.16.6.23 client-id=1:6c:3c:7c:f4:30:17 mac-address=\
    6C:3C:7C:F4:30:17 server=dhcp-106-print
add address=172.16.6.24 client-id=1:6c:f2:d8:ae:67:f2 mac-address=\
    6C:F2:D8:AE:67:F2 server=dhcp-106-print
/ip dhcp-server network
add address=172.16.0.0/24 dns-server=172.16.0.1 gateway=172.16.0.1 netmask=24 \
    ntp-server=172.16.0.1
add address=172.16.2.0/23 dns-server=172.16.2.1 gateway=172.16.2.1 netmask=23 \
    ntp-server=172.16.2.1
add address=172.16.4.0/23 dns-server=172.16.4.1 gateway=172.16.4.1
add address=172.16.6.0/24 dns-server=172.16.6.1 gateway=172.16.6.1
add address=172.16.10.0/24 dns-server=172.16.10.1 domain=dot.local gateway=\
    172.16.10.1 netmask=24 ntp-server=172.16.10.1
add address=172.16.11.0/24 dns-server=172.16.11.1 gateway=172.16.11.1 \
    netmask=24 ntp-server=172.16.11.1
add address=172.16.12.0/24 dns-server=172.16.12.1 gateway=172.16.12.1
add address=172.17.1.0/24 dns-server=172.17.1.1 gateway=172.17.1.1
add address=172.25.20.0/29 gateway=172.25.20.1
add address=192.168.0.0/24 dns-server=192.168.0.1 gateway=192.168.0.1
/ip dns
set allow-remote-requests=yes servers=9.9.9.9,1.1.1.2,8.8.8.8
/ip firewall address-list
add address=10.10.10.4 comment=DC-01 list=Allow_RDP_Azure
add address=10.10.10.14 comment=Service_Desk list=Allow_RDP_Azure
add address=10.10.10.5 comment=DC-02 list=Allow_RDP_Azure
add address=10.10.10.4 list=Azure_DNS
add address=10.10.10.5 list=Azure_DNS
add address=10.10.10.7 comment=Medoc list=Allow_RDP_Azure
add address=10.10.10.6 comment=DOT-AAD list=Allow_RDP_Azure
add address=10.10.10.11 comment=PAM list=Allow_RDP_Azure
add address=192.168.0.0/24 disabled=yes list=Allow_LAN_to_IPsec
add address=192.168.100.0/24 disabled=yes list=Allow_LAN_to_IPsec
add address=10.10.10.9 comment=Syslog list=Allow_RDP_Azure
add address=172.16.0.0/24 list=Allow_LAN_to_IPsec
add address=172.16.2.0/23 list=Allow_LAN_to_IPsec
add address=13.107.64.0/18 list=Teams_IP
add address=52.112.0.0/14 list=Teams_IP
add address=52.120.0.0/14 list=Teams_IP
add address=52.238.119.141 list=Teams_IP
add address=10.0.23.5 list=Azure_DNS
add address=10.10.10.0/24 list=ALL_AZURE
add address=10.0.23.0/24 list=ALL_AZURE
add address=10.10.10.9 list=Azure_DNS
add address=10.0.6.0/24 list=ALL_AZURE
add address=10.0.5.0/24 list=ALL_AZURE
add address=10.0.5.68 list=Allow_RDP_Azure
add address=10.0.5.68 list=Azure_DNS
add address=10.0.5.69 list=Allow_RDP_Azure
add address=10.0.6.132 list=Allow_RDP_Azure
add address=10.0.5.133 list=Allow_RDP_Azure
add address=10.0.5.65 list=Allow_RDP_Azure
add address=10.0.6.69 list=Allow_RDP_Azure
add address=10.0.6.132 list=Azure_DNS
add address=10.10.10.10 comment=Medoc list=Allow_RDP_Azure
add address=10.10.10.4 comment=DOT-DC01 list=Azure_Services
add address=10.10.10.14 comment=Servicedesk list=Azure_Services
add address=10.10.10.5 comment=DOT-DC02 list=Azure_Services
add address=10.10.10.7 comment=Medoc list=Azure_Services
add address=10.10.10.6 comment=AAD list=Azure_Services
add address=10.10.10.11 list=Azure_Services
add address=10.10.10.9 comment=SysLog list=Azure_Services
add address=10.0.23.5 comment=Grafana list=Azure_Services
add address=10.0.5.69 list=Azure_Services
add address=10.0.5.68 comment=askod-stage-app list=Azure_Services
add address=10.0.6.132 comment=askod-prod-db list=Azure_Services
add address=10.0.5.132 comment=askod-stage-db list=Azure_Services
add address=10.0.5.65 list=Azure_Services
add address=10.0.6.69 comment=askod-prod-app list=Azure_Services
add address=10.10.10.10 comment=Master list=Azure_Services
add address=10.8.0.0/24 list=ALL_AZURE
add address=10.8.0.4 list=Allow_RDP_Azure
add address=10.8.0.4 comment=PAM list=Azure_Services
add address=10.10.10.4 comment=DOT-DC01 list=Change_MSS
add address=10.10.10.5 comment=DOT-DC02 list=Change_MSS
add address=10.10.10.6 comment=AAD list=Change_MSS
add address=10.10.10.9 comment=Syslog list=Change_MSS
add address=10.0.23.5 comment=Grafana list=Change_MSS
add address=10.0.5.68 comment=askod-stage-app list=Change_MSS
add address=10.0.6.132 comment=askod-prod-db list=Change_MSS
add address=10.0.5.132 comment=askod-stage-db list=Change_MSS
add address=10.0.6.69 comment=askod-prod-app list=Change_MSS
add address=10.10.10.10 comment=Master list=Change_MSS
add address=10.8.0.4 comment=PAM list=Change_MSS
add address=10.10.10.6 list=Azure_DNS
add address=172.16.12.0/24 list=Allow_LAN_to_IPsec
add address=10.10.10.4 comment=DC-01 list=Azure_IT
add address=10.10.10.5 comment=DC-02 list=Azure_IT
add address=10.10.10.6 comment=AAD list=Azure_IT
add address=10.10.10.7 comment=Medoc list=Azure_IT
add address=10.10.10.9 comment=Syslog list=Azure_IT
add address=10.10.10.10 comment=Master list=Azure_IT
add address=10.10.10.14 comment=ServiceDesk list=Azure_IT
add address=10.0.5.69 comment=askod-stage-app list=Azure_IT
add address=10.0.5.133 comment=askod-stage-db list=Azure_IT
add address=10.0.6.69 comment=askod-prod-app list=Azure_IT
add address=10.0.6.132 comment=askod-prob-db list=Azure_IT
add address=10.0.23.5 comment=grafana list=Azure_IT
add address=10.8.0.4 comment=PAM list=Azure_IT
add address=10.10.10.7 comment=Medoc disabled=yes list=Change_MSS
add address=10.10.10.7 comment=Medoc list=Azure_accounting
add address=10.10.10.10 comment=Master list=Azure_accounting
add address=10.10.10.14 comment=ServiceDesk list=Azure_accounting
add address=10.0.6.69 comment=askod-prod-app list=Azure_accounting
add address=10.10.10.17 comment=New_Medoc list=Allow_RDP_Azure
add address=10.10.10.17 comment=Medoc list=Azure_accounting
add address=10.10.10.18 comment=SMB_Findoc list=Azure_IT
add address=10.10.10.18 comment=Findoc-SMB list=Azure_Services
add address=10.10.10.18 comment=Findoc-SMB list=Azure_accounting
add address=10.10.10.18 comment=SMB_findoc list=Allow_RDP_Azure
add address=10.10.10.19 comment=New_Medoc list=Azure_IT
add address=10.0.6.196 comment=askod-prod-app list=Azure_IT
add address=10.8.0.4 list=Azure_PAM
add address=10.1.0.4 list=Azure_PAM
add address=10.1.0.4 comment=PAM list=Azure_IT
add address=10.0.6.69 list=Azure_PAM
add address=10.0.5.68 list=ASKOD
add address=10.0.6.69 list=ASKOD
add address=10.0.23.5 list=ASKOD
add address=10.8.0.4 list=ASKOD
add address=10.1.0.4 list=ASKOD
add address=10.2.0.4 list=ASKOD
add address=10.3.0.4 list=ASKOD
add address=172.16.11.0/24 list=Allow_LAN_to_IPsec
add address=172.16.10.0/24 list=Allow_LAN_to_IPsec
add address=172.16.31.30 list=SDO
add address=172.16.31.5 list=SDO
add address=172.16.31.4 list=SDO
add address=198.18.19.20 list=SDO
add address=eclient.treasury.gov.ua list=BUH
add address=10.10.10.21 comment=master-blob-prod list=Azure_IT
add address=10.10.10.20 comment=master-blob-dev list=Azure_IT
add address=192.168.35.4 list=Azure_IT
add address=10.8.0.20 list=Azure_IT
add address=10.10.10.22 comment=SMB_Findoc list=Azure_IT
add address=10.10.252.0/29 list=Azure_IT
add address=10.10.252.0/29 list=Azure_accounting
add address=10.10.252.4 list=Azure_ALL
add address=10.2.0.5 comment=SIP list=Azure_IT
add address=10.2.0.5 list=Azure_ALL
add address=10.2.0.0/24 list=ALL_AZURE
add address=10.10.252.0/24 list=ALL_AZURE
add address=10.2.0.5 comment=Grafana list=Change_MSS
add address=10.2.0.5 comment=Syslog list=Allow_RDP_Azure
add address=10.8.0.4 list=Azure_DNS
add address=10.0.5.132 comment=askod-stage-db list=Azure_IT
add address=10.10.10.10 list=Azure_ALL
/ip firewall filter
add action=drop chain=input comment=Drop_forward_INVALID connection-state=\
    invalid
add action=accept chain=forward comment=Allow_ESTABLISHED_RELATED_UNTRACKED \
    connection-state=established,related,untracked
add action=drop chain=forward comment=Drop_forward_INVALID connection-state=\
    invalid
add action=accept chain=input comment=Allow_ESTABLISHED_RELATED_UNTRACKED \
    connection-state=established,related,untracked
add action=accept chain=input icmp-options=8:0-255 in-interface=sfp-sfpplus2 \
    protocol=icmp
add action=accept chain=input dst-port=8291 in-interface=sfp-sfpplus2 \
    protocol=tcp src-address=134.209.248.0
add action=accept chain=input dst-port=8291 in-interface=sfp-sfpplus2 \
    protocol=tcp src-address=185.41.250.108
add action=accept chain=input in-interface=sfp-sfpplus2 protocol=ipsec-esp
add action=accept chain=input dst-port=500,1701,4500 in-interface=\
    sfp-sfpplus2 protocol=udp
add action=drop chain=input in-interface=sfp-sfpplus2
add action=accept chain=input in-interface=vlan-100-mngmnt
add action=accept chain=input in-interface=ether15
add action=add-src-to-address-list address-list=Bad_IP address-list-timeout=\
    8h chain=input comment="Protect - PSD" in-interface-list=WAN protocol=tcp \
    psd=20,5s,3,1
add action=add-src-to-address-list address-list=Bad_IP address-list-timeout=\
    8h chain=input dst-port=22,23,80,88,8080 in-interface-list=WAN protocol=\
    tcp
add action=accept chain=input comment=Allow_ESTABLISHED_RELATED_UNTRACKED \
    connection-state=established,related,untracked
add action=drop chain=input comment=Drop_forward_INVALID connection-state=\
    invalid
add action=accept chain=forward comment=Allow_ESTABLISHED_RELATED_UNTRACKED \
    connection-state=established,related,untracked
add action=drop chain=forward comment=Drop_forward_INVALID connection-state=\
    invalid
add action=jump chain=input comment="Jump into management input-chain" \
    in-interface=vlan-100-mngmnt jump-target=mngmnt-input
add action=accept chain=input comment=TEMP dst-port=8291 in-interface=bridge \
    protocol=tcp
add action=accept chain=mngmnt-input comment=Allow_from_management dst-port=\
    22,53,67-68,123,161,8291 protocol=tcp
add action=accept chain=mngmnt-input dst-port=53,67-68,123 protocol=udp
add action=accept chain=mngmnt-input protocol=icmp
add action=accept chain=mngmnt-input protocol=ipsec-ah
add action=accept chain=mngmnt-input dst-port=8275 protocol=udp
add action=drop chain=mngmnt-input log=yes log-prefix=DROP_INPUT_MNGMNT
add action=accept chain=input ipsec-policy=in,ipsec protocol=icmp \
    src-address=192.168.35.4
add action=jump chain=input comment="Jump into IT input-chain" in-interface=\
    vlan-110-it jump-target=it-input
add action=accept chain=it-input comment=Allow_from_IT dst-port=\
    22,53,67-68,123,8291 protocol=tcp
add action=accept chain=it-input dst-port=53,67-68,123 protocol=udp
add action=accept chain=it-input protocol=icmp
add action=accept chain=it-input protocol=ipsec-ah
add action=drop chain=it-input log=yes log-prefix=DROP_INPUT_IT
add action=jump chain=input comment="Jump into Lan input-chain" in-interface=\
    vlan-102-lan jump-target=lan-input
add action=accept chain=lan-input comment=Allow_from_LAN dst-port=\
    53,67-68,123 protocol=tcp
add action=accept chain=lan-input dst-port=53,67-68,123 protocol=udp
add action=accept chain=lan-input protocol=icmp
add action=accept chain=lan-input protocol=ipsec-ah
add action=drop chain=lan-input log=yes log-prefix=DROP_INPUT_LAN
add action=jump chain=input comment="Jump into Guest input-chain" \
    in-interface=vlan-104-guest jump-target=guest-input
add action=accept chain=guest-input comment=Allow_from_guest dst-port=\
    53,67-68,123 protocol=tcp
add action=accept chain=guest-input dst-port=53,67-68,123 protocol=udp
add action=accept chain=guest-input protocol=icmp
add action=drop chain=guest-input log=yes log-prefix=DROP_INPUT_GUEST
add action=jump chain=input comment="Jump into Print input-chain" \
    in-interface=vlan-106-print jump-target=print-input
add action=jump chain=input in-interface=vlan-106-print jump-target=\
    print-input
add action=accept chain=print-input comment=Allow_from_Print dst-port=\
    53,67-68,123 protocol=tcp
add action=accept chain=print-input dst-port=53,67-68,123 protocol=udp
add action=accept chain=print-input protocol=icmp
add action=drop chain=print-input log=yes log-prefix=DROP_INPUT_PRINT
add action=jump chain=input comment="Jump into CCTV input-chain" \
    in-interface=vlan-107-cctv jump-target=cctv-input
add action=accept chain=cctv-input comment=Allow_from_CCTV dst-port=\
    53,67-68,123 protocol=tcp
add action=accept chain=cctv-input dst-port=53,67-68,123 protocol=udp
add action=accept chain=cctv-input protocol=icmp
add action=drop chain=cctv-input log=yes log-prefix=DROP_INPUT_CCTV
add action=jump chain=input comment="Jump into Buh input-chain" in-interface=\
    vlan-111-buh jump-target=buh-input
add action=accept chain=buh-input dst-port=53,67-68,123 protocol=tcp
add action=accept chain=buh-input dst-port=53,67-68,123 protocol=udp
add action=accept chain=buh-input protocol=icmp
add action=accept chain=buh-input protocol=ipsec-ah
add action=drop chain=buh-input log=yes log-prefix=DROP_INPUT_BUH
add action=jump chain=input comment="Jump into Pam input-chain" in-interface=\
    vlan-112-pam jump-target=pam-input
add action=accept chain=pam-input dst-port=53,67-68,123 protocol=tcp
add action=accept chain=pam-input dst-port=53,67-68,123 protocol=udp
add action=accept chain=pam-input protocol=icmp
add action=accept chain=pam-input protocol=ipsec-ah
add action=drop chain=pam-input
add action=accept chain=input comment=Allow_local_requests dst-address=\
    127.0.0.1
add action=accept chain=input comment=Allow_DNS_DHCP_from_lan_guest dst-port=\
    53,67-68,123 in-interface=bridge protocol=tcp
add action=accept chain=input dst-port=53,67-68,123 in-interface=bridge \
    protocol=udp
add action=accept chain=input comment=Allow_DNS_DHCP_from_lan_guest dst-port=\
    53,67-68,123 in-interface-list=VLAN_INPUT protocol=tcp
add action=accept chain=input dst-port=53,67-68,123 in-interface-list=\
    VLAN_INPUT protocol=udp
add action=accept chain=input comment=Allow_ICMP_from_VLAN in-interface-list=\
    VLAN_INPUT protocol=icmp
add action=accept chain=input comment=Allow_ICMP_from_Azure icmp-options=\
    8:0-255 in-interface-list=WAN protocol=icmp src-address=20.215.252.183
add action=accept chain=input comment=Allow_DNS_DHCP_from_lan_guest \
    ipsec-policy=in,ipsec src-address=10.0.23.5
add action=accept chain=input in-interface=vlan-102-lan
add action=accept chain=input comment=Allow_IPsec_from_WAN dst-port=\
    500,4500,1701 in-interface-list=WAN protocol=udp
add action=log chain=forward connection-rate=0-102400k disabled=yes \
    in-interface=vlan-104-guest log-prefix=GUEST_TEST_
add action=drop chain=input comment=Drop_input_ALL log=yes log-prefix=\
    DROP_INPUT_OTHER_
add action=jump chain=forward comment="Jump into IT forward-chain" \
    in-interface=vlan-110-it jump-target=it-forward
add action=accept chain=it-forward out-interface=vlan-106-print
add action=accept chain=it-forward log=yes out-interface=vlan-100-mngmnt
add action=accept chain=it-forward disabled=yes log=yes out-interface=\
    vlan-100-mngmnt
add action=accept chain=it-forward out-interface=vlan-102-lan
add action=accept chain=it-forward disabled=yes out-interface=*1E
add action=accept chain=it-forward out-interface=bridge
add action=accept chain=it-forward dst-address-list=Azure_IT dst-port=\
    22,53,80,443,1433,1812,1813,3001,3389,5060,5391,8282,8283,9116,9090 \
    ipsec-policy=out,ipsec log-prefix=IT_LOG protocol=tcp #правило застосовується для трафіку, що йде через IPsec.
add action=accept chain=it-forward dst-address-list=Azure_IT dst-port=\
    53,514,1812,1813,3389,5060,10000-20000 ipsec-policy=out,ipsec protocol=\
    udp
add action=accept chain=it-forward dst-address-list=Azure_IT ipsec-policy=\
    out,ipsec protocol=icmp
add action=drop chain=it-forward dst-port=23,135-139,445,7680 \
    out-interface-list=WAN protocol=tcp
add action=drop chain=it-forward dst-port=23,135-139,445,7680 \
    out-interface-list=WAN protocol=udp
add action=accept chain=it-forward ipsec-policy=out,none out-interface-list=\
    WAN
add action=drop chain=it-forward
add action=jump chain=forward comment="Jump into Buh forward-chain" \
    in-interface=vlan-111-buh jump-target=buh-forward
add action=accept chain=buh-forward out-interface=vlan-106-print
add action=accept chain=buh-forward out-interface=bridge
add action=accept chain=buh-forward dst-address-list=Azure_accounting \
    dst-port=53,80,443,445,3389,8282,8283,9996,9997 ipsec-policy=out,ipsec \
    log-prefix=TEST_LOG_ protocol=tcp
add action=accept chain=buh-forward dst-address-list=Azure_accounting \
    dst-port=53,3389,9996,9997 ipsec-policy=out,ipsec protocol=udp
add action=drop chain=buh-forward dst-port=23,135-139,445,7680 \
    out-interface-list=WAN protocol=tcp
add action=drop chain=buh-forward dst-port=23,135-139,445,7680 \
    out-interface-list=WAN protocol=udp
add action=accept chain=buh-forward ipsec-policy=out,none out-interface-list=\
    WAN
add action=drop chain=buh-forward log=yes log-prefix=BUH_DROP_
add action=jump chain=forward comment="Jump into Guest forward-chain" \
    in-interface=vlan-112-pam jump-target=pam-forward
add action=accept chain=pam-forward comment=Allow_forward_from_Guest \
    dst-address-list=Azure_PAM dst-port=22,80,443,8282,8283 ipsec-policy=\
    out,ipsec protocol=tcp
add action=accept chain=pam-forward dst-address-list=Azure_PAM dst-port=\
    53,67-68,123 ipsec-policy=out,ipsec protocol=udp
add action=accept chain=pam-forward out-interface=vlan-106-print
add action=accept chain=pam-forward out-interface=bridge
add action=accept chain=pam-forward protocol=icmp
add action=drop chain=pam-forward dst-port=23,135-139,445,7680 \
    out-interface-list=WAN protocol=tcp
add action=drop chain=pam-forward dst-port=23,135-139,445,7680 \
    out-interface-list=WAN protocol=udp
add action=accept chain=pam-forward ipsec-policy=out,none out-interface-list=\
    WAN
add action=drop chain=pam-forward
add action=jump chain=forward comment="Jump into LAN forward-chain" \
    in-interface=vlan-102-lan jump-target=lan-forward
add action=accept chain=lan-forward disabled=yes dst-address-list=Azure_IT \
    ipsec-policy=out,ipsec
add action=drop chain=lan-forward dst-port=23,135-139,445,7680 \
    out-interface-list=WAN protocol=tcp
add action=drop chain=lan-forward dst-port=23,135-139,445,7680 \
    out-interface-list=WAN protocol=udp
add action=accept chain=lan-forward comment=Allow_forward_from_ALL_LAN \
    dst-address-list=Azure_ALL dst-port=80,443,5060 ipsec-policy=out,ipsec \
    protocol=tcp
add action=accept chain=lan-forward comment=Allow_forward_from_ALL_LAN \
    dst-address-list=Azure_ALL dst-port=5060,10000-20000 ipsec-policy=\
    out,ipsec protocol=udp
add action=accept chain=lan-forward ipsec-policy=out,none out-interface=\
    vlan-106-print
add action=accept chain=lan-forward ipsec-policy=out,none out-interface=\
    bridge
add action=accept chain=lan-forward ipsec-policy=out,none out-interface-list=\
    WAN
add action=drop chain=lan-forward log=yes log-prefix=LAN_102_
add action=jump chain=forward comment="Jump into Mngmnt forward-chain" \
    in-interface=vlan-100-mngmnt jump-target=mngmnt-forward
add action=accept chain=mngmnt-forward dst-address-list=Azure_IT \
    ipsec-policy=out,ipsec
add action=drop chain=mngmnt-forward dst-port=23,135-139,445,7680 \
    out-interface-list=WAN protocol=tcp
add action=drop chain=mngmnt-forward dst-port=23,135-139,445,7680 \
    out-interface-list=WAN protocol=udp
add action=accept chain=mngmnt-forward log=yes log-prefix=MANAGEMENT_FORWARD \
    out-interface-list=WAN
add action=drop chain=mngmnt-forward
add action=accept chain=forward comment="Router fw IPsec out accept" \
    dst-address-list=Allow_RDP_Azure dst-port=\
    22,53,80,443,445,1812,1813,3389,8282,8283,9996,9997,19999,9090 log=yes \
    log-prefix=IPSEC_TCP_ protocol=tcp src-address-list=Allow_LAN_to_IPsec
add action=accept chain=forward comment="Router fw IPsec out accept" \
    dst-address-list=Allow_RDP_Azure dst-port=9115,9093,3001,3050 \
    ipsec-policy=out,ipsec log-prefix=IPSEC_TCP_ protocol=tcp \
    src-address-list=Allow_LAN_to_IPsec
add action=accept chain=forward comment="Router fw IPsec out accept" \
    dst-address-list=Allow_RDP_Azure dst-port=53,514,1812,1813,3389,9996,3050 \
    ipsec-policy=out,ipsec log=yes log-prefix=IPSEC_UDP_ protocol=udp \
    src-address-list=Allow_LAN_to_IPsec
add action=accept chain=forward comment=Allow_mngmnt_to_IPSEC dst-address=\
    10.10.10.9 src-address=172.16.0.0/24
add action=accept chain=forward comment="Router fw IPsec out accept" \
    dst-address-list=Allow_RDP_Azure ipsec-policy=out,ipsec log-prefix=\
    IPSEC_ICMP_ protocol=icmp src-address-list=Allow_LAN_to_IPsec
add action=accept chain=forward comment=Allow_LAN_to_MANAGEMENT disabled=yes \
    in-interface=vlan-102-lan out-interface=vlan-100-mngmnt
add action=accept chain=forward comment=Allow_LAN_to_Printers in-interface=\
    vlan-102-lan log-prefix=LAN_to_PRINTERS_ out-interface=bridge
add action=accept chain=forward comment=Allow_LAN_to_Printers disabled=yes \
    in-interface=vlan-104-guest log-prefix=LAN_to_PRINTERS_ out-interface=\
    bridge
add action=accept chain=forward comment=Allow_LAN_to_Printers in-interface=\
    vlan-102-lan log-prefix=LAN_to_PRINTERS_ out-interface=vlan-106-print
add action=accept chain=forward comment=Allow_LAN_to_Printers in-interface=\
    vlan-107-cctv log-prefix=LAN_to_PRINTERS_ out-interface=vlan-107-cctv
add action=accept chain=forward dst-address=172.16.0.0/24 src-address=\
    10.0.23.5
add action=drop chain=forward comment=Drop_LAN_to_WAN dst-port=\
    23,135-139,445,7680 in-interface-list=VLAN_to_INET ipsec-policy=out,none \
    out-interface-list=WAN protocol=tcp
add action=drop chain=forward dst-port=23,135-139,445,7680 in-interface-list=\
    VLAN_to_INET ipsec-policy=out,none out-interface-list=WAN protocol=udp
add action=accept chain=forward comment=Allow_LAN_to_WAN in-interface-list=\
    VLAN_to_INET ipsec-policy=out,none log-prefix=OUT_INTERFACE_LISTS_ \
    out-interface-list=WAN
add action=drop chain=forward comment=Drop_forward_ALL connection-nat-state=\
    !dstnat log=yes log-prefix=DROP_FORWARD_ALL
/ip firewall nat
add action=src-nat chain=srcnat dst-address=10.10.10.6 protocol=icmp \
    src-address=95.67.32.90 to-addresses=172.16.0.1
add action=src-nat chain=srcnat dst-address=10.10.10.9 protocol=icmp \
    src-address=95.67.32.90 to-addresses=172.16.0.1
add action=src-nat chain=srcnat dst-address=10.10.10.4 protocol=icmp \
    src-address=95.67.32.90 to-addresses=172.16.0.1
add action=src-nat chain=srcnat dst-address=10.0.23.5 protocol=icmp \
    src-address=95.67.32.90 to-addresses=172.16.0.1
add action=src-nat chain=srcnat ipsec-policy=out,none out-interface=\
    sfp-sfpplus2 src-address=172.16.10.0/24 to-addresses=95.67.32.90 #правило застосовується, якщо трафік не йде через IPsec.
add action=src-nat chain=srcnat ipsec-policy=out,none out-interface=\
    sfp-sfpplus2 src-address=172.16.4.0/23 to-addresses=95.67.32.94
add action=src-nat chain=srcnat ipsec-policy=out,none out-interface=\
    sfp-sfpplus2 to-addresses=95.67.32.92
/ip ipsec identity
add my-id=address:185.41.250.116 peer=palo-alto policy-template-group=group14 \
    remote-id=address:20.215.248.98
add peer=Azure
/ip ipsec policy
set 0 disabled=yes
add disabled=yes dst-address=10.10.10.0/24 peer=Azure proposal=Azure_phase2 \
    src-address=172.16.0.0/16 tunnel=yes
add disabled=yes dst-address=10.0.23.0/24 peer=Azure proposal=Azure_phase2 \
    src-address=172.16.0.0/16 tunnel=yes
add disabled=yes dst-address=10.8.0.0/24 peer=Azure proposal=Azure_phase2 \
    src-address=172.16.0.0/16 tunnel=yes
add disabled=yes dst-address=10.0.6.0/24 peer=Azure proposal=Azure_phase2 \
    src-address=172.16.0.0/16 tunnel=yes
add disabled=yes dst-address=10.10.252.0/29 peer=Azure proposal=Azure_phase2 \
    src-address=172.16.0.0/16 tunnel=yes
add disabled=yes dst-address=10.0.5.0/24 peer=Azure proposal=Azure_phase2 \
    src-address=172.16.0.0/16 tunnel=yes
add disabled=yes dst-address=10.2.0.0/24 peer=Azure proposal=Azure_phase2 \
    src-address=172.16.0.0/16 tunnel=yes
add disabled=yes dst-address=10.1.0.0/24 peer=Azure proposal=Azure_phase2 \
    src-address=172.16.0.0/16 tunnel=yes
add disabled=yes dst-address=192.168.35.0/24 peer=palo-alto proposal=\
    palo-crypto-profile src-address=192.168.0.0/24 tunnel=yes
add disabled=yes dst-address=192.168.35.0/24 peer=palo-alto proposal=\
    palo-crypto-profile src-address=172.16.10.0/24 tunnel=yes
/ip route
add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=95.67.32.89 \
    routing-table=main scope=30 suppress-hw-offload=no target-scope=10
add disabled=yes distance=1 dst-address=20.56.66.54/32 gateway=95.67.32.89 \
    pref-src=95.67.32.90 routing-table=main scope=30 suppress-hw-offload=no \
    target-scope=10
add disabled=yes distance=1 dst-address=20.56.66.56/32 gateway=95.67.32.89 \
    pref-src=95.67.32.90 routing-table=main scope=30 suppress-hw-offload=no \
    target-scope=10
/ip service
set ftp disabled=yes
set ssh address=172.16.0.0/24,172.16.2.0/23,192.168.0.0/24
set telnet disabled=yes
set www disabled=yes
set winbox address="172.16.0.0/24,172.16.2.0/23,172.16.20.0/24,172.16.10.0/24,\
    192.168.88.0/24,134.209.248.0/32,185.41.250.108/32"
set api disabled=yes
set api-ssl disabled=yes
/system clock
set time-zone-name=Europe/Kyiv
/system identity
set name=MK-6-floor
/system logging
set 0 topics=info,!firewall
set 1 topics=error,script
add disabled=yes prefix=BUH_TRAFFIC_ topics=info,firewall
add disabled=yes prefix=IPSEC_ topics=ipsec,debug
add disabled=yes topics=info,firewall
add action=Syslog topics=info,firewall
add action=Syslog topics=warning
add action=Syslog topics=error
add action=Syslog topics=critical
add action=Syslog topics=info,interface
add action=Syslog regex="query from" topics=dns
add disabled=yes prefix=BUH_TRAFFIC_ topics=info,firewall
add disabled=yes prefix=IPSEC_ topics=ipsec,debug
add disabled=yes topics=info,firewall
/system routerboard settings
set enter-setup-on=delete-key
/system scheduler
add disabled=yes interval=5m name=ipsec on-event=ipsec-script policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=2025-11-11 start-time=10:00:00
/system script
add dont-require-permissions=no name=ipsec-script owner=mk-8 policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="\
    \r\
    \n:if ([:len [/system script environment find name=\"ipsec_check_running\"\
    ]] > 0) do={\r\
    \n    :log warning \"IPSec check already running \97 exiting.\"\r\
    \n    :return\r\
    \n}\r\
    \n:global \"ipsec_check_running\" true\r\
    \n\r\
    \n:local peers {\"10.10.10.6\"; \"10.10.10.4\"; \"10.0.23.5\"}\r\
    \n:local ipsecPeerName \"Azure\"\r\
    \n:local webhookURL \"https://dotua.webhook.office.com/webhookb2/a81aee41-\
    5d02-43c0-b45f-911b6b4781d5@430feac2-3812-4946-be83-a9ff788c4e23/IncomingW\
    ebhook/506945de41ae426e8d54fc15274fa804/52e067de-21f2-4bb9-821c-adf4d6b50d\
    c0/V2FfrsBI5V3lyjdy6i5HXY5T5X5QES6QdUQdUiLQEOm681\"\r\
    \n:local alertHeader \"Content-Type: application/json\"\r\
    \n\r\
    \n:global ipsecDownSince\r\
    \n:global ipsecPreviouslyDown\r\
    \n\r\
    \n:local failureDetected false\r\
    \n:local failedPeers \"\"\r\
    \n\r\
    \n:foreach peer in=\$peers do={\r\
    \n    :local pingResult [ping \$peer count=6]\r\
    \n    :log info \"Ping result for \$peer: \$pingResult\"\r\
    \n    :if (\$pingResult = 0) do={\r\
    \n        :set failureDetected true\r\
    \n        :set failedPeers (\$failedPeers . \"\$peer failed; \")\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n:if (\$failureDetected = true) do={\r\
    \n\r\
    \n    :if ([:typeof \$ipsecDownSince] != \"time\") do={\r\
    \n        :set ipsecDownSince [/system clock get time]\r\
    \n        :log warning \"Tunnel: \$ipsecPeerName marked as DOWN at \$ipsec\
    DownSince\"\r\
    \n    }\r\
    \n\r\
    \n    :if (\$ipsecPreviouslyDown != true) do={\r\
    \n        :log error \"Tunnel is down! Notifying and restarting IPSec.\"\r\
    \n\r\
    \n        /tool fetch http-method=post \\\r\
    \n            http-header-field=\$alertHeader \\\r\
    \n            http-data=\"{\\\"text\\\": \\\"IPSec down: \$failedPeers (At\
    : \$ipsecDownSince). Reconnecting...\\\"}\" \\\r\
    \n            url=\$webhookURL keep-result=no\r\
    \n\r\
    \n        /ip ipsec peer disable [find name=\"\$ipsecPeerName\"]\r\
    \n        /ip ipsec policy disable [find peer=\"\$ipsecPeerName\"]\r\
    \n        /ip ipsec identity disable [find peer=\"\$ipsecPeerName\"]\r\
    \n        /ip ipsec active-peers kill-connections\r\
    \n        /ip ipsec installed-sa flush\r\
    \n        :delay 5s\r\
    \n        /ip ipsec identity enable [find peer=\"\$ipsecPeerName\"]\r\
    \n        :foreach i in=[/ip ipsec policy find where (peer=\"\$ipsecPeerNa\
    me\")] do={\r\
    \n            /ip ipsec policy enable \$i\r\
    \n            :delay 5s\r\
    \n        }\r\
    \n        :delay 5s\r\
    \n        /ip ipsec peer enable [find name=\"\$ipsecPeerName\"]\r\
    \n        :delay 5s\r\
    \n        :foreach i in=[/ip ipsec policy find where (ph2-state=\"no-phase\
    2\")] do={\r\
    \n            /ip ipsec policy disable \$i\r\
    \n            :delay 5s\r\
    \n            /ip ipsec policy enable \$i\r\
    \n        }\r\
    \n    }\r\
    \n\r\
    \n    :set ipsecPreviouslyDown true\r\
    \n\r\
    \n} else={\r\
    \n\r\
    \n    :if (\$ipsecPreviouslyDown = true) do={\r\
    \n\r\
    \n        :local now [/system clock get time]\r\
    \n        :log info \"Tunnel is now UP \97 was down since \$ipsecDownSince\
    \"\r\
    \n\r\
    \n        /tool fetch http-method=post \\\r\
    \n            http-header-field=\$alertHeader \\\r\
    \n            http-data=\"{\\\"text\\\": \\\"IPSec tunnel restored at \$no\
    w. Previously down since \$ipsecDownSince.\\\"}\" \\\r\
    \n            url=\$webhookURL keep-result=no\r\
    \n\r\
    \n        :set ipsecDownSince\r\
    \n        :set ipsecPreviouslyDown false\r\
    \n    } else={\r\
    \n        :log info \"IPSec tunnel is up. All peers reachable.\"\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n\r\
    \n:global \"ipsec_check_running\"\r\
    \n:set \"ipsec_check_running\"\r\
    \n"
/tool mac-server
set allowed-interface-list=none
/tool mac-server mac-winbox
set allowed-interface-list=none
/tool mac-server ping
set enabled=no
