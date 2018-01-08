#
# Collection of generic reusable bash functions
#

#
# Set of colors if we want a fancy output.
# Do not use if we are going to log output.
# Do not forget to use -e flag to echo.
#
BLUE="\[\033[0;34m\]"
RED="\[\033[0;31m\]"
LIGHT_RED="\[\033[1;31m\]"
GREEN="\[\033[0;32m\]"
LIGHT_GREEN="\[\033[1;32m\]"
WHITE="\[\033[1;37m\]"
LIGHT_GRAY="\[\033[0;37m\]"
DEFAULT="\[\033[0m\]"

# get_term_size()
# Gets the terminal size as reported by dialog and places it in two provided
# variables. We can not run dialog in a sub-process or we will always get the
# default term size of 24x80.
# depends: dialog
# parameters: 1- Name of the terminal height variable (defaults T_HEIGHT)
#             2- Name of the terminal width variable (defaults T_WIDTH)
# output: none, just fills the variables
#
get_term_size()
{
	local IFS=$' '
	local tempfile="/tmp/gts_$$" _term_h _term_w
	local -a _sizes
	declare -n _term_h=${1:-T_HEIGHT}
	declare -n _term_w=${2:-T_WIDTH}
	dialog --print-maxsize 2> $tempfile
	_sizes=( $(sed -E 's/^.*\: ([1-9]{1,}), ([1-9]{1,})/\1 \2/g' <$tempfile) )
	_term_h=${_sizes[0]:-0}
	_term_w=${_sizes[1]:-0}
	rm -f $tempfile
}

# txt2menu_list()
# Reads a text file and creates an array with its lines.
# Then builds an string in format "linenum line separator linenum ..."
# Separator should be the one used in dialog's menu item.
# parameters:	1.- A file name
#		2.- Separator char
#		3.- external variable name
# output:	none, passes the resulting string in var $3
# returns:	0 on success, 15 on failure
#
txt2menu_list()
{
	local IFS=$'\n' _array _str
	declare -a _array
	_array=( $(cat "$1" ) ) || return 15
	declare -n _str=${3:-RET_STR}

	j=0
	while [ $j -lt ${#_array[*]} ]; do
		_str="$_str$(( j+1 ))$2${_array[$j]##*\/}$2"
		(( j++ ))
		done
	# strip the trailing separator char
	_str=${_str%:}
}

# report_msg()
# Simple reporting formater, intended to be used to standarize messages.
# Use printf instead of a simple echo because of compatibilty issues.
# Parameters:	1.- should be the caller program name (but can be anything)
#		2.- a significative string
# Output:	Prints formatted message to stdout
# Returns:	0 on success, 1 on failure
report_msg()
{
	printf " -- %s --> %s\n" "$1" "$2" || return 1
}

# generate a pseudo-aleatory number between $1 and $2 lower ad upper limits
randomize()
{
	local i=0
	while [[ $i -lt $1 ]]; do
		i=$(( RANDOM %= $2 ))
	done
	echo "$i"
}

# read_lines()
# Given a text file,  read it and put it's lines in an array
# named $2. Array must be declared globally.
# parameters:	1.- a text file
#		2.- the name of an array variable (declared by the caller)
#		    defaults to _LINES
# output:	nome, fills the array variable.
# returns:	the return value of the while loop
read_lines()
{
	local IFS=$'\n' _array
	declare -n _array=${2:-_LINES}
	while read -r; do
		_array=( ${_array[@]} $REPLY )
	done <"$1"
}

# menu dialog
# WARNING: use ":" as IFS in the "tag item" pairs
# WARNING: $_backtitle should be declared script global for consistency
# parameters:	1- "tag item" pairs, usually via command substitution
#		2- variable name to store dialog's returned value
#		3- other dialog options, eg: --no-items, placed in an array
#		4- menu descriptive text
#		5- chained dialog in an array (--and-widget ...)
# output:	selected menu tag stored in $2 provided variable name
# returns:	dialog return code
#
menu_dlg()
{
	local tempfile="/tmp/menu_dlg_$$"
	# get terminal size
	#
	local _H=
	local _W=
	get_term_size _H _W

	# clear is a harcoded option, add others if non empty param
	#
	declare -n _options=${3:-_MENU_OPTS}
	declare -n _chain=${5:-_CHAINED_DLG}
	local IFS=":"
	declare -n _dlg_test=${2:-_DLG_TEST}
	dialog --clear ${_options[@]} --backtitle "${_backtitle:-Dialog}" \
		--menu " ${4:-Menu} " $((_H/2)) $((_W/2)) 6 \
		$1 2> $tempfile \
		${_chain[@]}
	local rc=$?
	_dlg_test="$(cat $tempfile)"
	rm -f "$tempfile"
	return $rc
}

# aborting message
# WARNING: $_backtitle should be declared script global for consistency
# parameters:	1- Error related messages
#		2- other dialog options, eg: --no-items
# output:	none
#
abort_dlg()
{
	local _options=( --clear )
	[[ ! -z $2 ]] && _options+=( $2 )

	dialog ${_options[@]} --backtitle "$_backtitle" \
		--msgbox "${1:-Aborting}" $((_H / 2)) $((_W / 2))
}

# is_running()
# Check if a program  is running. If not, offer to run it.
# Needs dialog, pgrep and the program, of course.
# Parameters:	1- name of the program to test (no path)
#		   include params to run it if it is not already running.
#		   e.g. amuled_(-f)
#		2.- Text for --backtitle dialog's option (optional)
# Output:	none
# Returns:	0 if running, 1 otherwise.
is_running()
{
	local _dialog="$(which dialog)"
	local _pgrep="$(which pgrep)"
	local _program="${1%_*}";
	local _path_program="$(which "$_program")"
	local _prog_parms="${1#*(}"; _prog_parms="${_prog_parms%)}"
	local _rc
	get_term_size _h _w
	if ! "$_pgrep" "$_program" >/dev/null 2>&1
	then
		$_dialog --clear --backtitle "$2" \
			--yesno "$_path_program is not running.\nDo you want to init it?\n" 0 0 
		_rc="$?"
		case "$_rc" in
			0)	if ! "$_path_program" "$_prog_parms" >/dev/null 2>&1; then
					report_msg "$0" "Error: Failed to run $_path_program $_prog_parms"
					return 1
				fi
				return 0 ;;
			*)	return 1 ;;
		esac
	else
		return 0
	fi
}
