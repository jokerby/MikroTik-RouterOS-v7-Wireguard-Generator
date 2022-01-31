#!/bin/sh

username=$1
address=$2
netmask=$3
exp=$4
mtip=<ip address of MikroTik Router>
mtsshport=<ssh port to MT Router>
mtuser=<ssh username MT Router>
interface=<wireguard interface name on MT Router>
port=$(ssh $mtuser@$mtip -p $mtsshport ":put [/interface/wireguard/get $interface value-name=listen-port]")
endpoint="<ip address or dns name of vpn server>:$port"
dns='<local dns ip(s) separated by commas>'
publickeyserver=$(ssh $mtuser@$mtip -p $mtsshport ":put [/interface/wireguard/get $interface value-name=public-key]")
persistentkeepalive=30
allowedips='<local routed network(s) in CIDR separated by commas>'

echo 'Creating keys...'
privatekey=$(wg genkey)
publickey=$(printf '%s' "$privatekey" | wg pubkey)
presharedkey=$(wg genpsk)

echo 'Adding peer to MT...'
ssh $mtuser@$mtip -p $mtsshport "/interface/wireguard/peers/add interface=$interface preshared-key=$presharedkey comment=$username allowed-address=$address public-key=$publickey persistent-keepalive=$persistentkeepalive"

echo 'Generating config...'
conf="[Interface]
PrivateKey = $privatekey
Address = $address/$netmask
DNS = $dns

[Peer]
PublicKey = $publickeyserver
PresharedKey = $presharedkey
AllowedIPs = $allowedips
Endpoint = $endpoint
PersistentKeepalive = $persistentkeepalive"
echo "$conf"
if test -n "${exp-}"; then
	echo 'Exporting config to file...'
	echo "$conf" > "$exp/$username.conf"
fi
exit 0
