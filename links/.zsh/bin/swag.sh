swag () {
    if [ $# -lt 1 ]; then
        echo "Usage: swag <file name> [remote name]"
        echo ""
        echo "Uploads a file to swag.brian.fm--basically the best collection ever of"
        echo "files and images. If <file name> is a URL, the file is first downloaded."
        echo "If [remote name] is specified, it will be anointed thusly on swag.brian.fm."
        return 1
    fi

	local tmp_dir=/tmp
	local file_name=$(basename $1)
	local local_src="$1"
	local scp_target=swaghaus:.swag

	# we may want a custom filename
	[[ $# -gt 1 ]] && file_name="$2"

	# local_src not so local after all; download it!
	if [[ $1 =~ ^https?: ]]; then
		local_src="${tmp_dir}/${file_name}"
		curl -Ls $1 > $local_src
	fi

	scp $local_src ${scp_target}/${file_name}

	# only delete the local copy if this function put it there
	case $local_src in $tmp_dir*)
		rm -f $local_src ;;
	esac
}
