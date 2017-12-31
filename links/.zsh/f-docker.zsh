#清除不使用的镜像
cleanup-unused-images (){
    docker rmi $(grep -xvf <(docker ps -a --format '{{.Image}}') <(docker images | tail -n +2 | grep -v '<none>' | awk '{ print $1":"$2 }'))
}

# docker-cleanup-volumes清除挂载点
cleanup-volumes (){
    wget https://raw.githubusercontent.com/chadoe/docker-cleanup-volumes/master/docker-cleanup-volumes.sh && sudo bash docker-cleanup-volumes.sh
}


getContainerIP() {
    [[ -z $1 ]] && { echo "Usage: ${FUNCNAME} CONTAINER-ID"; return; }
    docker inspect --format '{{ .NetworkSettings.IPAddress }}' $1
}

getContainerName() {
    [[ -z $1 ]] && { echo "Usage: ${FUNCNAME} CONTAINER-ID"; return; }
    docker inspect --format '{{ .Name }}' $1
}

getAllContainerIP() {
    for CONTAINER in $(docker ps -q); do
	printf "[%-12s] %-20s %s\n" ${CONTAINER} $(getContainerName ${CONTAINER}): $(getContainerIP ${CONTAINER})
    done
}

removeAllContainers() {
    docker rm $(docker ps -a -q)
}

#####################Shell函数来清理docker的东西

function docker-clean(){
    local _ELEMENT_="${1}"
    local _ID_="${2}"

    case ${_ELEMENT_} in
 containers ) local _COMMAND_="docker rm -f" ;;
     images ) local _COMMAND_="docker rmi -f" ;;
    volumes ) local _COMMAND_="docker volume rm" ;;
          * ) echo "ERROR: You must use images/containers/volumes as first parameter"
    esac

    case ${_ID_} in
        all ) case ${_ELEMENT_} in
     containers ) local _PARAMS_=( $(docker ps -qa) ) ;;
         images ) local _PARAMS_=( $(docker images -q) ) ;;
        volumes ) local _PARAMS_=( $(docker volume ls -q) ) ;;
              esac
             ;;
   dangling ) case ${_ELEMENT_} in
     containers ) local _PARAMS_=( $(docker ps -qa --filter 'status=exited' --filter 'status=created') ) ;;
         images ) local _PARAMS_=( $(docker images -q --filter "dangling=true") ) ;;
        volumes ) local _PARAMS_=( $(docker volume ls -q --filter 'dangling=true') ) ;;
              esac
             ;;
         '' ) echo "ERROR: You must use all/dangling/<id>/<name> as second parameter";;
          * ) local _PARAMS_=( ${_ID_} ) ;;
    esac
    
    [[ -z "${_PARAMS_}" ]] && return 0

    for item in ${_PARAMS_[*]}; do
        eval "${_COMMAND_} ${item}"
    done
}

##################################

# 例子： docker-run-daemon suweia/ubuntu:latest
function docker-run-daemon() {
	CID_LONG=$(sudo docker run -d $*  /bin/sh -c "while true; do echo hello world; sleep 1; done")
	echo $CID_LONG
}

# docker-run-it suweia/ubuntu:latest
function docker-run-it() {
	sudo docker run -it --rm $*
}

# echo $(docker-cid suweia/ubuntu:latest)
function docker-cid() {
	CID=`docker ps | grep -Poi "^[0-9a-f]+[ \t]+$1" | grep -Poi "^[0-9a-f]+"`
	echo $CID
}

function docker-install-nsenter() {
	wget https://www.kernel.org/pub/linux/utils/util-linux/v2.24/util-linux-2.24.tar.gz; tar xzvf util-linux-2.24.tar.gz
	cd util-linux-2.24
	./configure --without-ncurses && make nsenter
	sudo cp nsenter /usr/local/bin
}

# echo $(docker-pid <container-id>)
# echo $(docker-pid $(docker-cid suweia/ubuntu:latest))
alias docker-pid="sudo docker inspect --format '{{.State.Pid}}'"
alias docker-ip="sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

function docker-stop() {
	sudo docker stop $(docker-cid $1)
}

# stop-all: 强制终止容器运行
function docker-stop-all() {
	# https://www.mankier.com/1/docker-ps
	# -f, --filter=[] Provide filter values. Valid filters: exited=<int> - containers with exit code of <int> label=<key> or label=<key>=<value> status=(created|restarting|running|paused|exited) name=<string> - container's name id=<ID> - container's ID
	# http://subosito.com/docker-tips/
	sudo docker stop $(docker ps -a -q)
}

# kill-all 强制终止容器运行，并将其从运行列表中移除
function docker-kill-all() {
	sudo docker rm -f $(docker ps -a -q)
}

# rm-all 安全地终止容器运行，并将其从运行列表中移除
function docker-rm-all() {
	docker rm $(docker ps -a -q)
}

# docker-rm: 终止一个或一组容器，并将其从运行列表中移除
function docker-rm() {
	for i in $@; do
		#echo $i
		local pid=$(dcpid "$i")
		[ "$pid" != "" ] && echo "Clear the stopped container: $i, $pid" && docker rm -f $pid
	done
}



#the implementation refs from https://github.com/jpetazzo/nsenter/blob/master/docker-enter
#
# docker-enter $(docker-cid suweia/ubuntu)
function docker-enter() {
    #if [ -e $(dirname "$0")/nsenter ]; then
    #Change for centos bash running
    if [ -e $(dirname '$0')/nsenter ]; then
        # with boot2docker, nsenter is not in the PATH but it is in the same folder
        NSENTER=$(dirname "$0")/nsenter
    else
        # if nsenter has already been installed with path notified, here will be clarified
        NSENTER=$(which nsenter)
        #NSENTER=nsenter
    fi
    [ -z "$NSENTER" ] && echo "WARN Cannot find nsenter" && return

    if [ -z "$1" ]; then
        echo "Usage: `basename "$0"` CONTAINER [COMMAND [ARG]...]"
        echo ""
        echo "Enters the Docker CONTAINER and executes the specified COMMAND."
        echo "If COMMAND is not specified, runs an interactive shell in CONTAINER."
    else
        PID=$(sudo docker inspect --format "{{.State.Pid}}" "$1")
        if [ -z "$PID" ]; then
            echo "WARN Cannot find the given container"
            return
        fi
        shift

        OPTS="--target $PID --mount --uts --ipc --net --pid"

        if [ -z "$1" ]; then
            # No command given.
            # Use su to clear all host environment variables except for TERM,
            # initialize the environment variables HOME, SHELL, USER, LOGNAME, PATH,
            # and start a login shell.
            #sudo $NSENTER "$OPTS" su - root
            sudo $NSENTER --target $PID --mount --uts --ipc --net --pid su - root
        else
            # Use env to clear all host environment variables.
            sudo $NSENTER --target $PID --mount --uts --ipc --net --pid env -i $@
        fi
    fi
}


##############

#显示所有容器的ip

docker-ip() {
    docker ps | while read line; do
        if $(echo "$line" | grep -q 'CONTAINER ID'); then
            echo -e "IP-ADDRESS\t$line"
        else
            CID=$(echo "$line" | awk '{print $1}');
            IP=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" "$CID");
            printf "%s\t%s\n" "${IP}" "${line}"
        fi
    done;
}


#########

alias dps='docker ps -a'
#进入docker的bash
function dosh(){
    docker exec -ti "$1" bash
}

#查看日志
function dolog(){
    docker logs --tail=10 -f "$1"
}

#获取一个容器的IP地址
function getip(){
    docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$1"
}


########################
REQUIRED_SHELL_FEATURES="sudo docker cat head base64 netstat tput ls rm eval read stat awk grep tr rlwrap"
PREVIOUSLY_ENTERED_DATA_DIR="$HOME/.cache/docker-shell"

TXTRED='\e[0;31m' # red
TXTGRN='\e[0;32m' # green
TXTYLW='\e[0;33m' # yellow
TXTBLU='\e[0;34m' # blue
TXTPUR='\e[0;35m' # purple
TXTCYN='\e[0;36m' # cyan
TXTWHT='\e[0;37m' # white
BLDRED='\e[1;31m' # red    - Bold
BLDGRN='\e[1;32m' # green
BLDYLW='\e[1;33m' # yellow
BLDBLU='\e[1;34m' # blue
BLDPUR='\e[1;35m' # purple
BLDCYN='\e[1;36m' # cyan
BLDWHT='\e[1;37m' # white
TXTRST='\e[0m'    # Text reset

function error {
	echo -e "$BLDRED$1$TXTRST"
}

function info {
	echo -e "$BLDGRN$1$TXTRST"
}

function header {
	echo -e "$BLDYLW$1$TXTRST"
}

function banner {
	echo -e "$BLDCYN$1$TXTRST"
}

function separator {
	head -c 64 < /dev/zero | tr '\0' "$1"
}

function up_one_line {
	# Go upper one line
	tput cuu1
	# Erase line
	tput el
}

function section_end {
	echo ""
	echo ""
}

function press_any_key {
	read -n1 -r -p "Press any key to proceed..."
}

function declare_var {
	# parameters: VAR, DATA 
	eval "export $VAR=\"$DATA\""
}

function _enter_data {
	# parameters: VAR, RLWRAP_ARGUMENTS, POSSIBLE_VALUES, PROMPT, PLACEHOLDER
	local FILE=$(tempfile)
	echo "$POSSIBLE_VALUES" > $FILE
	if [ -n "$DOSKER_SHELL_ID" ]; then
		local HISTORY_FILE="$PREVIOUSLY_ENTERED_DATA_DIR/$DOSKER_SHELL_ID-$VAR"
		if [ -f $HISTORY_FILE ]; then
			PLACEHOLDER=$(cat $HISTORY_FILE)
		fi
	fi
	local DATA=$(rlwrap $RLWRAP_ARGUMENTS --prompt-colour=Yellow --histsize=0 --substitute-prompt="$PROMPT: " --break-chars=',' --file $FILE --pre-given "$PLACEHOLDER" --one-shot cat)
	rm $FILE
	if [ -n "$DOSKER_SHELL_ID" ]; then
		mkdir -p "$PREVIOUSLY_ENTERED_DATA_DIR"
		echo "$DATA" > "$HISTORY_FILE"
	fi
	DATA="${DATA/ /}" declare_var
}

function enter_value {
	# parameters: VAR, POSSIBLE_VALUES, PROMPT, PLACEHOLDER
	_enter_data
}

function enter_file {
	# parameters: VAR, POSSIBLE_VALUES, PROMPT, PLACEHOLDER
	RLWRAP_ARGUMENTS="--complete-filenames" _enter_data
}

function select_value {
	# parameters: VAR, POSSIBLE_VALUES[], PROMPT
	local PS3=$(header "$PROMPT: ")
	select opt in "${POSSIBLE_VALUES[@]}"; do
		case $opt in
			*)
				if [ -n "$opt" ]; then 
					break
				else
					error "Wrong option selected!"
				fi
			;;
		esac
	done
	DATA="$opt" declare_var
}

function docker_select_image {
	# parameters: VAR
	banner "Please select docker image from list:"
	local POSSIBLE_VALUES=($(sudo docker images | awk 'NR>1 { print $1; }' | grep -v "<none>" | tr '\n' ' '))
	PROMPT="Image number" select_value
	up_one_line
	header "Using image \"${!VAR}\""
	section_end
}

function docker_enter_image_name {
	# parameters: VAR, POSSIBLE_NAME
	banner "Please enter image name (usually in format user/name):"
	local LABEL="Image name"
	PROMPT="$LABEL" PLACEHOLDER="local/$POSSIBLE_NAME" POSSIBLE_VALUES="$POSSIBLE_NAME" enter_value
	up_one_line
	header "$LABEL \"${!VAR}\""
	section_end
}

function docker_select_container {
	# parameters: VAR, DESC 
	banner "Please select docker container ($DESC) from list:"
	local POSSIBLE_VALUES=($(sudo docker ps --format="{{.Names}}" | tr '\n' ' '))
	PROMPT="Container number" select_value
	up_one_line
	header "Using container \"${!VAR}\": $DESC"
	section_end
}

function docker_enter_container_name {
	# parameters: VAR, IMAGE
	banner "Please enter container name (to be displayed in list of running containers, format: container-name):"
	local PLACEHOLDER=$(echo $IMAGE | cut -d '/' -f2)
	local LABEL="Container name"
	PROMPT="$LABEL" POSSIBLE_VALUES="$PLACEHOLDER" enter_value
	up_one_line
	header "$LABEL \"${!VAR}\""
	section_end
}

function docker_enter_dir {
	# parameters: VAR, DESC, POSSIBLE_VALUES, PLACEHOLDER 
	banner "Please enter host $DESC directory:"
	PROMPT="Path" enter_file
	up_one_line
	mkdir -pv "${!VAR}"
	header "Using $DESC directory \"${!VAR}\", contents:"
	ls --almost-all -C --quote-name --classify --group-directories-first --color=always "${!VAR}"
	section_end
}

function docker_enter_file {
	# parameters: VAR, DESC, POSSIBLE_VALUES, PLACEHOLDER
	banner "Please enter host file with $DESC:"
	PROMPT="File" enter_file
	up_one_line
	local SIZE=$(stat -c%s "${!VAR}")
	header "Using $DESC file \"${!VAR}\", size: $SIZE bytes"
	section_end
}

function docker_enter_port {
	# parameters: VAR, DESC, POSSIBLE_VALUES, PLACEHOLDER
    banner "Please enter host port to expose $DESC to the world:"
    PROMPT="Port" enter_value
    up_one_line
	local USAGE=$(sudo netstat -lnp | grep "^tcp\|udp" | grep ":${!VAR} ")
	local MESSAGE="$DESC port \"${!VAR}\""
	if [ -n "$USAGE" ]; then
		error "$MESSAGE port is in use:"
		error "$USAGE"
	else
		header "Using $MESSAGE"
    fi
    section_end
}

function docker_enter_value {
	# parameters: VAR, DESC, PROMPT, POSSIBLE_VALUES, PLACEHOLDER
	banner "Please enter $DESC:"
	if [ -z "$PROMPT" ]; then
		local PROMPT="$DESC"
	fi
	enter_value
	up_one_line
	header "Using $PROMPT \"${!VAR}\""
	section_end
}

function docker_enter_password {
	# parameters: VAR, DESC, PROMPT, LENGTH, RANDOM_SOURCE
	banner "Please enter password for $DESC (below is fresh generated one, ${BLDRED}last time to copy it${BLDCYN}, it will be hidden on pressing enter):"
	if [ -z "$PROMPT" ]; then
		local PROMPT="$DESC"
	fi
	if [ -z "$LENGTH" ]; then
		local LENGTH=24
	fi
	if [ -z "$RANDOM_SOURCE" ]; then
		local RANDOM_SOURCE=/dev/urandom
	fi
	PLACEHOLDER="$(cat $RANDOM_SOURCE | head -c $LENGTH | base64 | head -c $LENGTH)" enter_value
	up_one_line
	local PASS="${!VAR}"
	header "Using password for $PROMPT with length ${#PASS} symbols"
	section_end
}

function print_without_sensitive_data {
	# parameters: COMMAND, SENSITIVE_DATA
	local SUBST=$(head -c ${#SENSITIVE_DATA} < /dev/zero | tr '\0' '*')
	info "${COMMAND//$SENSITIVE_DATA/$SUBST}"
}

function _run {
	# parameters: COMMAND, SENSITIVE_DATA
	header "Will run:"
	header $(separator '-')
	print_without_sensitive_data
	header $(separator '-')
	press_any_key
	up_one_line
	
	eval "$COMMAND"
	section_end
}

function docker_run {
	# parameters: ARGUMENTS, CONTAINER_NAME, IMAGE, CONTAINER_COMMAND, SENSITIVE_DATA
	local COMMAND="sudo docker run $ARGUMENTS --name \"$CONTAINER_NAME\" --env TZ=\"$(cat /etc/timezone)\" --detach \"$IMAGE\" $CONTAINER_COMMAND"
	_run

	sudo docker ps
	section_end

	error $(separator '=')
	error "Tailing logs... It's safe to press CTRL+C to stop watching"
	error $(separator '=')
	section_end
	sudo docker logs -f "$CONTAINER_NAME"
}

function docker_build {
	# parameters: ARGUMENTS, IMAGE, DIR, SENSITIVE_DATA
	local COMMAND="sudo docker build --force-rm=true --rm=true $ARGUMENTS -t \"$IMAGE\" \"$DIR\""
	_run "$COMMAND"
}

for i in $REQUIRED_SHELL_FEATURES; do
    type $i >/dev/null 2>&1 || { echo -e "\n\n${BLDRED}Command \"${BLDCYN}$i${BLDRED}\" is not available! Required programs/shell features: ${TXTCYN}$REQUIRED_SHELL_FEATURES${TXTRST}\n\n"; exit 1; }
done


########################

getContainerIP() {
    [[ -z $1 ]] && { echo "Usage: ${FUNCNAME} CONTAINER-ID"; return; }
    docker inspect --format '{{ .NetworkSettings.IPAddress }}' $1
}

getContainerName() {
    [[ -z $1 ]] && { echo "Usage: ${FUNCNAME} CONTAINER-ID"; return; }
    docker inspect --format '{{ .Name }}' $1
}

getAllContainerIP() {
    for CONTAINER in $(docker ps -q); do
	printf "[%-12s] %-20s %s\n" ${CONTAINER} $(getContainerName ${CONTAINER}): $(getContainerIP ${CONTAINER})
    done
}

removeAllContainers() {
    docker rm $(docker ps -a -q)
}

function docker_fun {  
	printf "Functions:\ndocker_open <container_name> <container_port>=80\n\n"
} 

function docker_open {
  	container_port=${2:-"80"}
  	container=$1
  	echo "搜索容器: $container"
  	echo "容器端口: $container_port"
  	docker_machine=`docker-machine ip default`
  	port=`docker port $container | grep "$container_port" | awk '{print $3}' | awk -F":" '{print $2}'`
  	url="http://$docker_machine:$port"
  	echo "打开网址 : $url"
  	open "$url"
} 

dkr () {
    if [[ "$1" == "which" ]]; then
        docker-machine active
        return
    fi
    if [[ "$1" == "use" ]]; then
        eval "$(docker-machine env ${*:2})"
        return
    fi
}


＃显示Docker容器内正在运行的进程
dockertop() {
  DOCKERTOP=$1
  docker top ${DOCKERTOP} | sed -n '1!p' | sed 's/ \+/ /g'
}

＃显示有关搬运工容器一些统计
dockerstats() {
  docker stats --no-stream=true $(docker ps -q) | sed -n '1!p' | sed 's/ \+/,/g' | awk -F',' '{print $1","$2","$3","}'
}

＃简单的方法连接容器
dockerconn() {
  DOCKERCONN=$1
  docker exec -i -t ${DOCKERCONN} /bin/bash
}

＃显示Docker容器的日志
dockerlog() {
  DOCKERLOG=$1
  docker logs -f ${DOCKERLOG} --tail 100
}

＃这个野兽从多个docker命令收集运行容器的信息，并以对其他脚本友好的方式显示它。

function dockerlabelsscript(){
  MYHOSTNAME=$(hostname)
  MYFILE=$(mktemp)
  SearchContainer=$1
  #echo "${SearchContainer}"
  IFS=$'\n'
  (for i in $(docker ps --format "{{.ID}}~{{.Image}}~{{.RunningFor}}~{{.Ports}}~{{.Status}}~{{.Names}}~" | grep -E "${SearchContainer}"); do
    DockerId=$(echo "${i}" | awk -F'~' '{print $1}')
    DockerImage=$(echo "${i}" | awk -F'~' '{print $2}')
    DockerRunningFor=$(echo "${i}" | awk -F'~' '{print $3}')
    DockerPorts=$(echo "${i}" | awk -F'~' '{print $4}')
    DockerPorts=$(echo "${DockerPorts}" | awk -F':' '{print $2}' | awk -F'-' '{print $1}')
    if [[ ! "${DockerPorts}" ]]; then DockerPorts="NA"; fi
    DockerUpFor=$(echo "${i}" | awk -F'~' '{print $5}')
    DockerNames=$(echo "${i}" | awk -F'~' '{print $6}')
    DockerImage=$(echo "${DockerImage}" | sed 's/repository.cars.com\///g')
    DockerBuild=$(echo "${DockerImage}" | awk -F':' '{print $2}' | awk -F'-' '{print $1}')
    if [[ ! "${DockerBuild}" ]]; then DockerBuild="NA"; fi
    DockerImage=$(echo "${DockerImage}" |awk -F':' '{print $1}')
    OUTPUT=$(docker inspect --format="{{.Config.Labels.ENV}},{{.Config.Labels.APP_NAME}},{{.Config.Labels.BIGIP_POOL}}" ${DockerId})
    DockerLEnv=$(echo "${OUTPUT}" | awk -F',' '{print $1}')
    DockerLAppName=$(echo "${OUTPUT}" | awk -F',' '{print $2}')
    DockerLBigIPPool=$(echo "${OUTPUT}" | awk -F',' '{print $3}')
    if [[ "${DockerLEnv}" =~ "no value" ]]; then DockerLEnv="No_Label"; fi
    if [[ "${DockerLAppName}" =~ "no value" ]]; then DockerLAppName="No_Label"; fi
    if [[ "${DockerLBigIPPool}" =~ "no value" ]]; then DockerLBigIPPool="No_Label"; fi
    if [[ "${MYHOSTNAME}" =~ "10" || "${MYHOSTNAME}" =~ "00" ]]; then APPTYPE="app"; elif [[ "${MYHOSTNAME}" =~ "14" ]]; then  APPTYPE="svc"; fi
    if [[ -z "${APPTYPE}" ]]; then APPTYPE="other"; fi
    echo "${MYHOSTNAME}~${DockerId}~${DockerImage}:~${DockerBuild}~${DockerPorts}~${DockerUpFor}~${DockerLEnv}~${DockerLAppName}~${DockerLBigIPPool}~${APPTYPE}" >> "${MYFILE}"
  done)
  cat <(grep 'registrator' "${MYFILE}") <(grep -v 'registrator' "${MYFILE}")
}

＃获取容器使用的内存，用于我的DockerMemoryMon.sh脚本
dockerstatsscript() {
  local MYID=$1
  docker stats --no-stream=true ${MYID} | sed -n '1!p' | sed 's/ \+/,/g' | awk -F',' '{print $1","$2","$3","$4","}'
}

＃提取一些容器上的自定义标签。
function labellooker(){
  IFS=$'\n'
  MYDOCKERID=$1
  OUTPUT=$(docker inspect --format="{{.Config.Labels.ENV}},{{.Config.Labels.APP_NAME}},{{.Config.Labels.BIGIP_POOL}}" ${MYDOCKERID})
  DockerEnv=$(echo "${OUTPUT}" | awk -F',' '{print $1}')
  DockerAppName=$(echo "${OUTPUT}" | awk -F',' '{print $2}')
  DockerBigIPPool=$(echo "${OUTPUT}" | awk -F',' '{print $3}')
  if [[ "${DockerEnv}" =~ "no value" ]]; then DockerEnv="NA"; fi
  if [[ "${DockerAppName}" =~ "no value" ]]; then DockerAppName="NA"; fi
  if [[ "${DockerBigIPPool}" =~ "no value" ]]; then DockerBigIPPool="NA"; fi
  echo "${DockerEnv}~${DockerAppName}~${DockerBigIPPool}~"
}

＃显示所有正在运行的Docker容器，在我的情况下，我们首先要显示注册容器。

function getRunning(){
  IFS=$'\n'
  HOSTNAME=$(hostname)

  for i in $(docker ps | grep registrator | awk '{print $1}'); do
    #echo "registator is getting started"
    echo "${HOSTNAME},${i}"
  done

  for e in $(docker ps | grep -v registrator | grep -v CONTAINER  | awk '{print $1}'); do
    #echo "starting the rest"
    echo "${HOSTNAME},${e}"
  done
}

＃显示docker主机有多少devicemapper空间可用，已使用和总共。
function devicemapperget() {
  IFS=$'\n'
  #exec 2>/dev/null

  MYVARS=$(hostname)
  MYVARS+=$(echo ",")

  for i in $(docker info | grep Data | grep -v WARNING | grep -v 'file:'); do
    MYVARS+=$(echo "${i}" | awk -F':' '{print $2","}')
  done

  echo ${MYVARS} | tr -d '[:space:]'
}

＃显示非群集环境中容器发生的重启次数。如果达到重新启动计数限制，则不会启动，您将不得不重新部署。
function DockerRestartCount() {
  ImageName=$1
  docker inspect --format="{{.Config.Labels.ENV}},{{.Config.Labels.APP_NAME}},{{.Config.Labels.BIGIP_POOL}},{{.RestartCount}},{{.HostConfig.RestartPolicy.MaximumRetryCount}},{{.Config.Hostname}}" $(docker ps | grep -i -e "${ImageName}" | awk '{print $1}')
}

＃这将删除容器内部的堆转储，用于docker容器中的node.js应用程序。虽然这将删除堆，但不会释放设备映射器FS上的空间，直到您停止它们和docker system purge / docker rm容器。如果使用设备映射器，一定要监视它，当它填满时，你将不得不重建LVM。

function DockerHeapCleanUp() {
  IFS=$'\n'
  for DockerLine in $(docker ps | grep -v -E "registrator2|CONTAINER"); do
    DockerId=$(echo "${DockerLine}" | awk '{print $1}')
    DockerName=$(echo "${DockerLine}" | awk '{print $2}')
    for heap in $(docker exec ${DockerId} bash -c "ls -1 /app/heapdump*heapsnapshot"); do
      if [[ "${heap}" =~ "rpc error" ]]; then
        echo "Docker exec errors found on ${DockerName}"
      elif [[ ! "${heap}" =~ "heapsnapshot" ]]; then
        echo "No heaps found to clean on ${DockerName}"
      else
        echo "Deleting heapdump ${heap} for ${DockerId} - ${DockerName}"
        docker exec ${DockerId} bash -c "ls -hl ${heap}"
        docker exec ${DockerId} bash -c "rm ${heap}"
        # docker exec ${DockerId} bash -c "ls -hl ${heap}"
      fi
    done
    echo
  done
}

＃只有实验性的，从备份文件中删除文件不能按预期工作。
function DockerTakeHeapDump() {
  #DockerHeapCleanUp
  IFS=$'\n'
  HOSTNAME=$(hostname)
  local ContainerId=$1
  # use to be SIGURSR2 now it's SIGPIPE
  OUTPUT=$(docker kill -s PIPE "${ContainerId}")
  for heap in $(docker exec ${ContainerId} bash -c "ls -1 | grep heapdump*heapsnapshot"); do
    if [[ "${heap}" =~ "rpc error" ]]; then
      echo "Docker exec errors found on $(docker ps | grep ${ContainerId} | awk '{print $1" "$2}')"
    elif [[ ! "${heap}" =~ "heapsnapshot" ]]; then
      echo "No heaps found on $(docker ps | grep ${ContainerId} | awk '{print $1" "$2}')"
    else
      echo "${HOSTNAME} docker cp ${ContainerId}:/app/${heap} /tmp/${heap}"
      #echo "${HOSTNAME} docker exec ${ContainerId} bash -c \"rm ${heap}\""
      #echo "scp kaddyman@${HOSTNAME}:/tmp/${heap} /dockerheap/${heap}"
    fi
  done
}



＃ Millage将与这取决于你如何使用泊坞窗秘密而有所不同。

function SecretKitty(){
  DockerId=$1
  if [[ "${DockerId}" ]]; then 
    docker exec ${DockerId} bash -c 'for i in $(ls -1 /run/secrets/*); do echo "${i}"; cat "${i}"; done;'
  else
    echo "No Container was provided"
  fi
}


docker-bash() {
	docker exec -it "$1" bash
}


function docker-ssh () {
  if [[ $# -eq 0 ]]
  then
    echo "expected argument"
  else
    local host
    host=$1
    docker exec -it  $host /bin/bash
  fi
}

function _d_containers() {
  local -a completions
  for i in $(docker ps --format '{{.Names}}')
  do
    completions+=( $i )
  done
  _describe 'values' completions
}

######################################
#!/bin/bash
# Bash wrappers for docker run commands
# 
# Helper Functions
#
# docker-machine stuff
if [ $(which docker-machine) ]; then
  export C_DOCKER_MACHINE="default"

  dminit() {
    docker-machine start ${C_DOCKER_MACHINE}
    dmshell
  }

  dmshell() {
    eval $(docker-machine env ${C_DOCKER_MACHINE})
  }

  docker_if_not_running() {
    if [ $(docker-machine status ${C_DOCKER_MACHINE}) != 'Running' ]; then
      dminit
    fi
  }

  dmhosts() {
    DMHOSTNAME="dockerhost"

    sudo -v

    grep ${DMHOSTNAME} /etc/hosts > /dev/null && sudo sed -i '' "/${DMHOSTNAME}/d" /etc/hosts
    sudo echo "$(docker-machine ip ${C_DOCKER_MACHINE}) ${DMHOSTNAME}" | sudo tee -a /etc/hosts
  }

  if [ $(docker-machine status ${C_DOCKER_MACHINE}) == 'Running' ]; then
    dmshell &> /dev/null
  fi

fi # end docker-machine

# Xquartz stuff
xquartz_if_not_running() {
  v_nolisten_tcp=$(defaults read org.macosforge.xquartz.X11 nolisten_tcp)
  v_xquartz_app=$(defaults read org.macosforge.xquartz.X11 app_to_run)

  if [ $v_nolisten_tcp == "1" ]; then
    defaults write org.macosforge.xquartz.X11 nolisten_tcp 0
  fi

  if [ $v_xquartz_app != "/usr/bin/true" ]; then
    defaults write org.macosforge.xquartz.X11 app_to_run /usr/bin/true
  fi

  netstat -an | grep 6000 &> /dev/null || open -a XQuartz
  while ! netstat -an \| grep 6000 &> /dev/null; do
    sleep 2
  done
  export DISPLAY=:0.0
}

dcleanup(){
	docker rm $(docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null
	docker rmi $(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null
}


del_stopped(){
	local name=$1
	local state=$(docker inspect --format "{{.State.Running}}" $name 2>/dev/null)

	if [[ "$state" == "false" ]]; then
		docker rm $name
	fi
}


relies_on(){
	local containers=$@

	for container in $containers; do
		local state=$(docker inspect --format "{{.State.Running}}" $container 2>/dev/null)

		if [[ "$state" == "false" ]] || [[ "$state" == "" ]]; then
			echo "$container is not running, starting it for you."
			$container
		fi
	done
}


openvas(){
         
  docker run -d -p 443:443 -p 9390:9390 -p 9391:9391 mikesplain/openvas
}

metasploit(){
  
  docker run -t -i --rm linuxkonsult/kali-metasploit

}


torbrowser(){
	del_stopped torbrowser
    xquartz_if_not_running
    docker_if_not_running
    xhost +$(docker-machine ip ${C_DOCKER_MACHINE})

    docker run -d \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-e DISPLAY=$(docker-machine inspect ${C_DOCKER_MACHINE} --format={{.Driver.HostOnlyCIDR}} | cut -d'/' -f1):0 \
		--name torbrowser \
		--net host \
		--security-opt seccomp:unconfined \
		jess/tor-browser

	 #exit current shell
	#exit 0
}

nes(){

    del_stopped nes
	xquartz_if_not_running
    docker_if_not_running
    xhost +$(docker-machine ip ${C_DOCKER_MACHINE})
	local game=$1

	docker run -d \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-e DISPLAY=$(docker-machine inspect ${C_DOCKER_MACHINE} --format={{.Driver.HostOnlyCIDR}} | cut -d'/' -f1):0 \
		--name nes \
		jess/nes /games/${game}.rom
}	

hollywood(){
	docker run --rm -it \
		--name hollywood \
		jess/hollywood
}

registrator(){
	del_stopped registrator

	docker run -d --restart always \
		-v /var/run/docker.sock:/tmp/docker.sock \
		--net host \
		--name registrator \
		gliderlabs/registrator consul://$(docker-machine ip ${C_DOCKER_MACHINE}):8500
}

libreoffice(){
	del_stopped libreoffice

	docker run -d \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-e DISPLAY=$(docker-machine inspect ${C_DOCKER_MACHINE} --format={{.Driver.HostOnlyCIDR}} | cut -d'/' -f1):0 \
		-v /Users/scottcoulton/Documents/slides:/root/slides \
		-e GDK_SCALE \
		-e GDK_DPI_SCALE \
		--name libreoffice \
		jess/libreoffice
}

consul(){
	del_stopped consul

	# check if we passed args and if consul is running
	local args=$@
	local state=$(docker inspect --format "{{.State.Running}}" consul 2>/dev/null)
	if [[ "$state" == "true" ]] && [[ ! -z "$args" ]]; then
		docker exec -it consul consul "$@"
		return 0
	fi

	docker run -d \
		--restart always \
		-v $HOME/.consul:/etc/consul.d \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-p 8500:8500 \
		-p 53:53/udp \
		--name consul \
		scottyc/consul \
		-bootstrap-expect 1 \
		-config-dir /etc/consul.d \
		-data-dir /data \
		-server \
		-dc gotham \
		-bind 0.0.0.0
}

rainbowstream(){
	del_stopped rainbowstream
    
     docker run -it --rm \
	    -v ~/.rainbow_oauth:/root/.rainbow_oauth \
	    --name rainbowstream \
	    jess/rainbowstream
}	

irssi(){
   del_stopped irssi
   docker run -it --rm \
   --name=irssi \
    -e TERM  \
    --log-driver=none \
    -v ~/.irssi:/home/user/.irssi \
    --read-only \
    irssi
}
norrisbot(){
     del_stopped norrisbot

     docker run -d \
     -e BOT_API_KEY="<ADD Key here>" \
     --name norrisbot \
     scottyc/norrisbot
	
}

dockerchrome() {
      del_stopped dockerchrome
      xquartz_if_not_running
      docker_if_not_running
      xhost +$(docker-machine ip ${C_DOCKER_MACHINE})
      
      docker run \
        --rm \
        --memory 512mb \
        --net host \
        --security-opt seccomp:unconfined \
        -e DISPLAY=$(docker-machine inspect ${C_DOCKER_MACHINE} --format={{.Driver.HostOnlyCIDR}} | cut -d'/' -f1):0 \
        -e GDK_SCALE \
        -e GDK_DPI_SCALE \
        jess/chrome
    }

dockerfirefox(){
	del_stopped firefox
    xquartz_if_not_running 
	docker_if_not_running
	xhost +$(docker-machine ip ${C_DOCKER_MACHINE})

	docker run -d \
		--memory 2gb \
		--net host \
		--cpuset-cpus 0 \
		--privileged=true \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-e DISPLAY=$(docker-machine inspect ${C_DOCKER_MACHINE} --format={{.Driver.HostOnlyCIDR}} | cut -d'/' -f1):0 \
		-e GDK_SCALE \
        -e GDK_DPI_SCALE \
		--name firefox \
		jess/firefox 

	# exit current shell
	#exit 0
} 


####################











































































