HOME_EDITOR_SUBL="${HOME}/bin/subl"
HOME_EDITOR="${HOME}/bin/e"

if [ ! -f "$HOME_EDITOR" ] || [ ! -f "$HOME_EDITOR_SUBL" ]; then
    mkdir -p ~/bin

    OSX_SUBLIME_BIN="/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"
    LINUX_SUBLIME_BIN="$(which subl 2>/dev/null)"
    LINUX_SUBLIME_HOME_BIN="$HOME/apps/sublime/sublime_text"
    LINUX_SUBLIME_OPT_BIN="/opt/sublime_text/sublime_text"
    VIM_LOCATION="$(which vim 2>/dev/null)"
    VI_LOCATION="$(which vi 2>/dev/null)"
    NANO_LOCATION="$(which nano 2>/dev/null)"
    PICO_LOCATION="$(which pico 2>/dev/null)"

    if [ -f "$OSX_SUBLIME_BIN" ]; then
        ln -fs "$OSX_SUBLIME_BIN" $HOME_EDITOR
        ln -fs "$OSX_SUBLIME_BIN" $HOME_EDITOR_SUBL
    elif [ -f "$LINUX_SUBLIME_OPT_BIN" ]; then
        ln -fs "$LINUX_SUBLIME_OPT_BIN" $HOME_EDITOR
        ln -fs "$LINUX_SUBLIME_OPT_BIN" $HOME_EDITOR_SUBL
    elif [ -f "$LINUX_SUBLIME_BIN" ]; then
        ln -fs "$LINUX_SUBLIME_BIN" $HOME_EDITOR
        ln -fs "$LINUX_SUBLIME_BIN" $HOME_EDITOR_SUBL
    elif [ -f "$LINUX_SUBLIME_HOME_BIN" ]; then
        ln -fs "$LINUX_SUBLIME_HOME_BIN" $HOME_EDITOR
        ln -fs "$LINUX_SUBLIME_HOME_BIN" $HOME_EDITOR_SUBL
    elif [ "$VIM_LOCATION" ]; then
        ln -fs $VIM_LOCATION $HOME_EDITOR
    elif [ "$VI_LOCATION" ]; then
        ln -fs $VI_LOCATION $HOME_EDITOR
    elif [ "$NANO_LOCATION" ]; then
        ln -fs $NANO_LOCATION $HOME_EDITOR
    elif [ "$PICO_LOCATION" ]; then
        ln -fs $PICO_LOCATION $HOME_EDITOR
    else:
        echo 'ERROR: No editors found. Good luck with sed, cat, and heredoc!' >2
    fi
fi

[ -f "$HOME_EDITOR" ] && export EDITOR="$(os_readlink_safe $HOME_EDITOR)"

if [ -f "$EDITOR" ]; then
    export EDITOR_NAME="$(basename "$(os_readlink_safe $EDITOR)")"
    export GIT_EDITOR="$EDITOR_NAME"

    if [[ "$EDITOR_NAME" =~ "^subl" ]]; then
        ## If we're on a machine using Sublime Text as our editor, instruct
        ## Sublime to wait (with -w) until the file git sends to it is closed
        ## before returning anything back to git. Otherwise, git sees an
        ## immediate exit and cancels the commit/rebase/merge/whatever due to
        ## no changes in the file.
        export GIT_EDITOR="$GIT_EDITOR -w"
    fi
fi
