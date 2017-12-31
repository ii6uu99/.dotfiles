function slip () {
    local srv_type="vs"
    local priv_only=false
    local ipmi_only=false

    while getopts hpi arg; do
        case $arg in
            h) srv_type="hw" ;;
            p) priv_only=true ;;
            i) ipmi_only=true ;;
        esac
    done

    shift $((OPTIND-1))
    local server=$1
    local pattern='/public_ip/'

    ( $ipmi_only ) && pattern="/ipmi_ip/"
    ( $priv_only ) && pattern="/private_ip/"

    sl $srv_type detail $server | awk "$pattern {print \$2}"
}

function slpw () {
    local srv_type="vs"

    while getopts h arg; do
        case $arg in
            h) srv_type="hw" ;;
        esac
    done

    shift $((OPTIND-1))
    local server=$1
    local pattern='/ root /'

    sl $srv_type detail --passwords $server | awk "$pattern {print \$NF}"
}
