function ec2() {
	if [ $# == 0 ]; then
		aws ec2 describe-instances | jq --raw-output 'include "aws"; getInstanceMetadata' | column -t -s $'\t' | sort
	fi
}
