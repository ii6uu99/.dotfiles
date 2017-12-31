function ssh-ready () {
    local default_port=22

    local ssh_host=$1
    local remote_host=${ssh_host#*@}
    local remote_port=${2:-$default_port}

    if [ $# -eq 0 ]; then
        echo "Usage: $0 <ip|hostname|alias> [ssh port]"
        echo ""
        echo "Evaluates true when a connection can successfully be"
        echo "established to <ip|hostname|alias> on TCP port ${remote_port},"
        echo "or an alternate TCP port, if specified."
        echo ""
        echo "Note that this will poll forever until forcibly stopped,"
        echo "or until a connection has successfully been established."
        echo ""
        echo "Example usage:"
        echo "\$ ssh-ready && ssh user@10.2.3.4"
        echo "\$ ip=10.2.3.4 while ! $0 \$ip; echo -n '.'; done; ssh user@\$ip -o SSHOption=terrific"
        return 1
    fi

    local waited=false
    local time_start_nsec=$(date +%s)
    local sleep_sec=1
    local timeout_sec=1

    while ! nc -w ${timeout_sec} -z $remote_host $remote_port; do
        waited=true
        echo -n '.'
        [ $sleep_sec -gt 0 ] && sleep ${sleep_sec}
    done

    if [[ "$waited" == true ]]; then
        local elapsed_sec=$(expr $(date +%s) - $time_start_nsec)
        echo "Connection established after ${elapsed_sec} seconds."
    fi

    return 0
}


function ssh-wait () {
    ssh-ready $1 && ssh $*
}


function yolossh () {
    if [ $# -eq 0 ]; then
        echo "Usage: $0 <host|user@host>"
        echo ""
        echo "Attempts to SSH to a host without using a known hosts file,"
        echo "nor doing any sort of strict host key checking. Additionally"
        echo "silences the accompanying warning by raising SSH's log level."
        echo ""
        echo "Other arguments can be provided just as they would to ssh."
        return 1
    fi

    ssh $@ -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o LogLevel=ERROR
}


# Courtesy of <http://blog.joshdick.net/2012/08/10/ssh_via_icloud.html>.

# On Mac OS X, SSH to another Mac by hostname via Back To My Mac (iCloud)
# The client and target machines must both have Back To My Mac enabled
# Adapted from code found at
# <http://onethingwell.org/post/27835796928/remote-ssh-bact-to-my-mac>

function ssh-icloud() {
    if [[ $# -eq 0 || $# -gt 2 ]]; then
        echo "Usage: $0 computername [username]"
    elif ! hash "scutil" &> /dev/null; then
        echo "$0 only works on Mac OS X! Aborting."
    else
        local _icloud_addr=`echo show Setup:/Network/BackToMyMac \
                            | scutil \
                            | sed -n 's/.* : *\(.*\).$/\1/p'`
        local _username=`whoami`
        if [[ $# -eq 2 ]]; then
            _username=$2
        fi
        ssh $_username@$1.$_icloud_addr
    fi
}
