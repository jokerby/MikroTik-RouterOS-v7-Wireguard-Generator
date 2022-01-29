/interface/wireguard/
#variables
:local presharedkey "<preshared key>";
:global username;
:local filename "$username.conf";
:global address;
:local interface "<wireguard interface name>";
:local tempinterface "temp";
:local publickeyserver [get $interface value-name=public-key];
:local persistentkeepalive 30;
:local dns "<local dns ip(s) separated by commas>";
:local port [get $interface value-name=listen-port];
:local endpoint "<ip address or dns name of vpn server>:$port";
:local allowedips "<local routed network(s) in CIDR separated by commas>";

#using temporary 
add name=$tempinterface
:local privatekey [get $tempinterface value-name=private-key];
:local publickey [get $tempinterface value-name=public-key];
remove $tempinterface;

#adding peer to MT
peers/add interface=$interface preshared-key=$presharedkey comment=$username allowed-address=$address public-key=$publickey persistent-keepalive=$persistentkeepalive

#exporting client side config to file
:local config "[Interface]\nPrivateKey = $privatekey\nAddress = $address\nDNS = $dns\n\n[Peer]\nPublicKey = $publickeyserver\nPresharedKey = $presharedkey\nAllowedIPs = $allowedips\nEndpoint = $endpoint\nPersistentKeepalive = $persistentkeepalive";
:put $config
/file print file=$filename
/file set $filename contents=$config
