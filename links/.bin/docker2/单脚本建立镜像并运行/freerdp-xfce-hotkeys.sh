#!/usr/bin/env bash

#
# This script is not to be run directly
# it handles hotkeys in XFCE and FreeRdp (being mapped as /usr/share/freerdp/action.sh into FreeRdp container) 
#

run() {
  local name=$1
  local host=$2
  local port=$3
  local user=$4
  local pass=$5

  echo "run $name $host $port $user pass"

  local screen_width=`wmctrl -d | head -1 | sed -r 's#.*DG: ([0-9]+)x([0-9]+) .*#\1#'`
  local screen_height=`wmctrl -d | head -1 | sed -r 's#.*DG: ([0-9]+)x([0-9]+) .*#\2#'`
  (
    # todo: clipboard issues
    # todo: +glyph-cache issues
    # todo: +offscreen-cache issue
    # todo: +auto-reconnect does not works
    #WLOG_FILTER=com.freerdp.*:TRACE 
    ~/docker/freerdp.sh /v:$host /port:$port /u:$user /p:$pass    \
                                  /t:"FreeRDP:$name"                        \
                                  +grab-keyboard                            \
                                  +clipboard                                \
                                  +auto-reconnect                           \
                                  +bitmap-cache -offscreen-cache -glyph-cache +decorations    \
                                  +async-update +async-input +async-transport +async-channels \
                                  /cert-ignore                              \
                                  /drive:Downloads,/home/user/Downloads     \
                                  /size:"${screen_width}x${screen_height}"  \
                                  /smart-sizing:600x333
    echo "exitcode=$?"
    # todo: show "disconnected" message
    # todo: execute again if disconnected, not killed. how to make difference? both exitcodes are "0". connect error is "131"
  )
}

switch_to() {
    local winid=$1
    local workspace=1
    # ensure workspace quantity
    if (( $(wmctrl -d | wc -l) < $((workspace + 1)) )); then wmctrl -n $((workspace + 1)); fi
    # move to workspace
    wmctrl -ir ${winid} -t $workspace
    # expand to full screen
    wmctrl -ir ${winid} -b add,fullscreen
    # activate: switch to the workspace and raise the window
    wmctrl -ia ${winid} 
}

switch_to_or_run() {
  local name=$1
  local host=$2
  local port=$3
  local user=$4
  local pass=$5
  #echo "name=$name host=$host port=$port user=$user pass=$pass"

  local winid=$(wmctrl -l | grep " FreeRDP:${name}\$" | gawk '{print $1}')
  if [ "${winid}" == "" ]; then
    run $name $host $port $user $pass
  else
    switch_to $winid
    #if [ $? != 0 ]; then
    #  run
    #fi
  fi
}

tile_rdp_windows() {
    local rdp_workspace=1
    local screen_width=`wmctrl -d | head -1 | sed -r 's#.*DG: ([0-9]+)x([0-9]+) .*#\1#'`
    local screen_height=`wmctrl -d | head -1 | sed -r 's#.*DG: ([0-9]+)x([0-9]+) .*#\2#'`
    local w=$((screen_width * 45 / 100)) 
    local h=$((screen_height * 45 / 100))
    local x=0
    local y=0
    local rdp_windows=$(wmctrl -l | grep ' FreeRDP:' | sort -k4 | gawk '{print $1}')
    for winid in $rdp_windows; do
      echo "$winid -> $x,$y,$w,$h"
      # ensure workspace quantity
      if (( $(wmctrl -d | wc -l) < $((rdp_workspace + 1)) )); then wmctrl -n $((rdp_workspace + 1)); fi
      # move to rdp_workspace
      wmctrl -ir ${winid} -t $rdp_workspace
      # set the size
      wmctrl -ir ${winid} -b remove,fullscreen
      wmctrl -ir ${winid} -b remove,maximized_vert
      wmctrl -ir ${winid} -b remove,maximized_horz
      wmctrl -ir ${winid} -e 0,$x,$y,$w,$h
      x=$((x+w+10))
      if (( x > 1000 )); then x=0; y=$((y+h+50)); fi
    done
}

switch_to_prev_rdp() {
  local active_window=$(wmctrl -a :ACTIVE: -v 2>&1 | tail -1 | gawk '{print $3}')
  local rdp_windows=$(wmctrl -l | grep ' FreeRDP:' | sort -k4 -r | gawk '{print $1}')
  local index=-1
  local i=0
  local target_winid=""
  for winid in $rdp_windows; do
    if [ $i == $((index + 1)) ]; then target_winid=$winid; fi
    if [ "$active_window" == "$winid" ]; then index=$i; fi
    i=$((i + 1))
  done
  #>&2 echo "p index=$index i=$i target_winid=$target_winid"
  #if [ $((index + 1)) == $i ]; then
  #  tile_rdp_windows
  #  wmctrl -s 0
  #else
    switch_to $target_winid
  #fi
}

switch_to_next_rdp() {
  local active_window=$(wmctrl -a :ACTIVE: -v 2>&1 | tail -1 | gawk '{print $3}')
  local rdp_windows=$(wmctrl -l | grep ' FreeRDP:' | sort -k4 | gawk '{print $1}')
  local index=-1
  local i=0
  local target_winid=""
  for winid in $rdp_windows; do
    if [ $i == $((index + 1)) ]; then target_winid=$winid; fi
    if [ "$active_window" == "$winid" ]; then index=$i; fi
    i=$((i + 1))
  done
  #>&2 echo "n index=$index i=$i target_winid=$target_winid"
  #if [ $((index + 1)) == $i ]; then
  #  tile_rdp_windows
  #  wmctrl -s 0
  #else
    switch_to $target_winid
  #fi
}

switch_to_next_rdp_or_desktop() {
  local active_window=$(wmctrl -a :ACTIVE: -v 2>&1 | tail -1 | gawk '{print $3}')
  local rdp_windows=$(wmctrl -l | grep ' FreeRDP:' | sort -k4 | gawk '{print $1}')
  local index=-1
  local i=0
  local target_winid=""
  for winid in $rdp_windows; do
    if [ $i == $((index + 1)) ]; then target_winid=$winid; fi
    if [ "$active_window" == "$winid" ]; then index=$i; fi
    i=$((i + 1))
  done
  #>&2 echo "n index=$index i=$i target_winid=$target_winid"
  if [ $((index + 1)) == $i ]; then
    tile_rdp_windows
    wmctrl -s 0
  else
    switch_to $target_winid
  fi
}

install_xfce_hotkeys() {
  # TODO: how to ensure XML entries from bash?
  # TODO?: "xfconf-query -c xfce4-keyboard-shortcuts -l -v"
  local thisdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

  # FILE: $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
  # <channel name="xfce4-keyboard-shortcuts" version="1.0">
  # # <property name="commands" type="empty">
  # # # <property name="custom" type="empty">
  # # # # <property name="Muhenkan" type="string" value="${thisdir}/freerdp-xfce-hotkeys.sh key Muhenkan"/>
  # # # # <property name="Henkan_Mode" type="string" value="${thisdir}/freerdp-xfce-hotkeys.sh key Henkan_Mode"/>
  # # # # <property name="Hiragana_Katakana" type="string" value="${thisdir}/freerdp-xfce-hotkeys.sh key Hiragana_Katakana"/>
  # # # # <property name="Katakana" type="string" value="${thisdir}/freerdp-xfce-hotkeys.sh key Katakana"/> <!--french keyboard only extra key is 'keycode 94 = less ...' remaped as Katakana-->
  # # # # <property name="XF86AudioPrev" type="string" value="${thisdir}/freerdp-xfce-hotkeys.sh key XF86AudioPrev"/>
  # # # # <property name="XF86AudioNext" type="string" value="${thisdir}/freerdp-xfce-hotkeys.sh key XF86AudioNext"/>
  # # # # <property name="XF86AudioStop" type="string" value="${thisdir}/freerdp-xfce-hotkeys.sh key XF86AudioStop"/>

  echo 'keycode 94 = Katakana' > ~/.Xmodmap
  xmodmap ~/.Xmodmap

}

if [ "$1" == "switch_to_or_run" ]; then
  shift
  switch_to_or_run "$@"
elif [ "$1" == "debug-tile" ]; then
  tile_rdp_windows
  #wmctrl -s 1
elif [ "$1" == "key" ]; then
  if [ "$2" == "" ]; then
#   echo "Ctrl+Alt+Break"
    echo "Katakana"
    echo "Muhenkan"
    echo "Henkan_Mode"
    echo "Hiragana_Katakana"
#   echo "XF86WakeUp"
    echo "XF86AudioStop"
    echo "XF86AudioPrev"
    echo "XF86AudioPlay"
    echo "XF86AudioNext"
  elif [ "$2" == "Ctrl-Alt-Break"                               ]; then
    # todo:toggle fullscreen of active rdp-window
    echo "key-local"
# elif [ "$2" == "XF86WakeUp"                                   ]; then tile_rdp_windows;   wmctrl -s 1; /usr/bin/xfce4-popup-whiskermenu;                                 echo "key-local"
  elif [ "$2" == "XF86AudioPrev" -o "$2" == "Katakana"          ]; then switch_to_next_rdp_or_desktop;                                                                     echo "key-local"
  elif [ "$2" == "XF86AudioPrev" -o "$2" == "Muhenkan"          ]; then switch_to_prev_rdp;                                                                                echo "key-local"
  elif [ "$2" == "XF86AudioNext" -o "$2" == "Henkan_Mode"       ]; then switch_to_next_rdp;                                                                                echo "key-local"
  elif [ "$2" == "XF86AudioStop" -o "$2" == "Hiragana_Katakana" ]; then tile_rdp_windows;   if [ "$(wmctrl -d | grep '0  \*')" ]; then wmctrl -s 1; else wmctrl -s 0; fi;  echo "key-local"
# elif [ "$2" == "XF86AudioPlay"                                ]; then                                                                                                    echo "key-local"
  else
    echo "key $2"
  fi
fi
