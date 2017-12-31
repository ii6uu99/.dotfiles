function sheb() {
	if [[ $# == "0" ]]; then
		echo "Usage: sheb <internal ip>"
		return 1
	fi

	# first add key to agent if necessary
	if [[ ! $(ssh-add -L) ]]; then
		ssh-add -K ~/.ssh/id_rsa
	fi

	if [[ $(echo "$1" | grep "@") ]]; then
		# If a username was provided, use it
		ssh -J virtyx -t "$1" "sudo su -"
	else
		# Otherwise, assume username is "ec2-user"
		ssh -J virtyx -t "ec2-user@$1" "sudo su -"
	fi
}
