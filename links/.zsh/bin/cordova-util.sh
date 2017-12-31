cordova-activate () {
    [[ ! -d "$HOME/app/cordova" ]] && \
    	echo "Error: $HOME/app/cordova not found" >&2 && \
    	return 1

    export CORDOVA_HOME=$HOME/app/cordova
    path_append $CORDOVA_HOME/bin
    prompt_suffix_add "cordova"
}

cordova-deactivate () {
    path_remove $CORDOVA_HOME/bin
    prompt_suffix_remove "cordova"
}
