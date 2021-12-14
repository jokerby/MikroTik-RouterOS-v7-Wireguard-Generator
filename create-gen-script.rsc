/system script
add dont-require-permissions=no name=wg policy=read,write,policy source="/interface/wireguard/\
    \n#variables\
    \n:local presharedkey \"<preshared key>\";\
    \n:global username;\
    \n:local filename \"\$username.conf\";\
    \n:global address;\
    \n:local interface \"<wireguard interface name>\";\
    \n:local tempinterface \"temp\";\
    \n:local publickeyserver [get \$interface value-name=public-key];\
    \n:local persistentkeepalive 30;\
    \n:local dns \"<local dns ip(s) separated by commas>\";\
    \n:local port [get \$interface value-name=listen-port];\
    \n:local endpoint \"<ip address or dns name of vpn server>:\$port\";\
    \n:local allowedips \"<local routed network(s) in CIDR separated by commas>\";\
    \n\
    \n#using temporary \
    \nadd name=\$tempinterface\
    \n:local privatekey [get \$tempinterface value-name=private-key];\
    \n:local publickey [get \$tempinterface value-name=public-key];\
    \nremove \$tempinterface;\
    \n\
    \n#adding peer to MT\
    \npeers/add interface=\$interface preshared-key=\$presharedkey comment=\$username allowed-address=\$address public-key=\$publickey persistent-keepalive=\$persistentkeepalive\
    \n\
    \n#exporting client side config to file\
    \n:local config \"[Interface]\\nPrivateKey = \$privatekey\\nAddress = \$address\\nDNS = \$dns\\n\\n[Peer]\\nPublicKey = \$publickeyserver\\nPresharedKey = \$presharedkey\\nAllowedIPs = \$allowedips\\nEndpoint = \$endpoint\\nPersistentKeepalive = \
    \$persistentkeepalive\";\
    \n:put \$config\
    \n/file print file=\$filename\
    \n/file set \$filename contents=\$config"
