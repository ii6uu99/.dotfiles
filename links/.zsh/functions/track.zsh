local function dateimpl() {
	if [[ $(uname) == "Darwin" ]]; then
		echo "gdate"
	else
		echo "date"
	fi
}

local function datediff() {
	local d0=$($(dateimpl) -d"$1" +%s)
	local d1=$($(dateimpl) -d"$2" +%s)
	echo "$(($d1 - $d0))"
}

function track() {
	if [[ $# -lt 1 ]]; then
		echo "Usage: track <start|stop|hours|archive>" && return 1
	fi
	local cmd=$1
	local trackdir

	if [[ $TRACK_ROOT ]]; then
		trackdir=$TRACK_ROOT
	else
		trackdir=~/.track
	fi
	local logfile="$trackdir/log"
	local startfile="$taskdir/started"
	local archivedir="$trackdir/archive"

	if [[ $cmd == "archive" ]]; then
		mkdir -p $archivedir
		mv "$logfile" "$archivedir/$($(dateimpl) --iso-8601=seconds)"
		return 0
	fi

	if [[ $# -lt 2 ]]; then
		echo "Usage: track $cmd <task>" && return 1
	fi
	local task=$2
	local taskdir="$trackdir/task/$task"

	mkdir -p "$taskdir"

	if [[ $cmd == "start" ]]; then
		if [[ -f $startfile ]]; then
			echo "Task $task was already started at $(cat $startfile)"
			return 1
		fi
		$(dateimpl) --iso-8601=seconds > "$startfile"
		return 0
	fi

	if [[ $cmd == "stop" ]]; then
		if [[ ! -f $startfile ]]; then
			echo "Task $task has not been started"
			return 1
		fi
		local started=$(cat "$startfile")
		local ended=$($(dateimpl) --iso-8601=seconds)
		echo "$task\t$started\t$ended" >> "$logfile"
		rm "$startfile"
		return 0
	fi

	if [[ $cmd == "hours" ]]; then
		local lines=("${(@f)$(grep "^$task" < "$logfile" | cut -f2,3)}")
		local sum=0
		for line in $lines; do
			local t0=$(echo "$line" | cut -f1)
			local t1=$(echo "$line" | cut -f2)
			diff=$(datediff "$t0" "$t1")
			sum=$((sum + diff))
		done
		echo "$(($sum / 3600.0))"
		return 0
	fi

	echo "Unrecognized command $cmd"
	return 1
}
