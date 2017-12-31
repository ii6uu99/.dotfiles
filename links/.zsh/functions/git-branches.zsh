green=`tput setaf 2`
reset=`tput sgr0`

git-branches() {
  set -f
  git branch | while read line; do
    current="  "
    name=${line##\* }   ## removes leading * for current

    if [ ! "$name" = "$line" ]; then
      current="${green}* "
    fi

    description=`git config "branch.$name.description"`

    if [ "$description" != "" ]; then
      description=" : $description"
    fi

    echo "${reset}${current}${name}${description}${reset}"
  done
  set +f
}
