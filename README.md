# RouterOS-v7-Wireguard-Generator
Automate generation of wireguard config

Simple script to auto adding new p2s vpn "account".

**Before the first run you need to edit the specific parameters inside script!**

## How to use
- Before running the script you need to set two parameters - address and username:
  - :global address \addresses with CIDR masks from which incoming traffic for this peer is allowed and to which outgoing traffic for this peer is directed\
  - :global username \user name used as comment and filename\
- /system/script/\script name\

### Example
:global address "10.100.200.3/32"

:global username "john.smith"

/system/script/wg


After executing these commands a new user will be added to wireguard/peers and a corresponding file will appear in the Files, which can be imported into the client.

**Unfortunately ROS for some reason add ".txt" extension to created file. _This must be fixed for import to be successful!_** Eg. john.smith.conf must be changed to john.smith.conf.

## TODO
- [ ] Replace hardcoded preshared key with a generated one
- [ ] Find a way to pass agruments directly to script
- [ ] Fix .txt file extension problem
- [ ] Replace temporary wg interface by more "elegant" solution a.k.a. direct generation
