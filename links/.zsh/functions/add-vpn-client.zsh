function add-vpn-client() {
	echo "./make_client.sh \"$1\"" | ssh vpn.burwell.io
	scp vpn.burwell.io:"~/client-configs/files/$1.ovpn" "$1.ovpn"
}
