# RouterOS v7 Wireguard Generator for Linux
Automate generation of wireguard config from any Linux machine

Simple script to auto adding new p2s vpn "account" in MT router, but directly from Linux machine. Without helps, usage examples, error checks etc.

**Before the first run you need to edit the specific parameters inside script and install wireguard binaries (for example: apt install wireguard)!**

_It is recommended to use an SSH key to avoid entering passwords multiple times on SSH connections_

## How to use
This script must be run not on the router directly, but on any other Linux machine.
The script takes 4 parameters, 3 of which are required:
1. Username - user name used as comment and filename
2. Address - addresses **without** CIDR masks from which incoming traffic for this peer is allowed and to which outgoing traffic for this peer is directed
3. Netmask - CIDR mask related to the previous parameter
4. (Optional) Export folder - the path where the text configuration will be exported

````
./gen.sh <username> <address> <netmask> [export folder]
````
After executing these commands a new user will be added to wireguard/peers and a corresponding configuration will be displayed on the screen and (if chosen) also be written to the file, each of which can be imported in the client.

### Example
````
./gen.sh jsmith 10.100.200.3 29
````
in this case, the configuration will be added to the router and displayed only on the screen
````
./gen.sh jsmith 10.100.200.3 29 /some/path
````
in this case, in addition to the previous example, the configuration will also be written to the file /some/path/jsmith.conf
