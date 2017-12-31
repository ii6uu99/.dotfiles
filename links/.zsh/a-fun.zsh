##自毁提示
rm()
{
  if [ "$1" = "-rf/" ]
  then
    shift
    echo '' && echo 'Do a self destruct in 5.. 4.. 3.. 2.. 1..' && echo 'Just kidding :p' && echo '' && echo "Let's taking a screenshot instead" && scrot -cd 5 "$@"
  else
    command rm "$@"
  fi
}


