# This lets you quickly jump into a project directory.
#
# Type:
#
#   c <tab>
#
# ...to autocomplete on all of your projects in the directories specified in
# `functions/_c`. Typically I'm using it like:
#
#    c holm<tab>/bo<tab>
#
# ...to quickly jump into holman/boom, for example.
#
# This also accounts for how Go structures its projects. For example, it will
# autocomplete both on $PROJECTS, and also assume you want to autocomplete on
# your Go projects in $GOPATH/src.

function c() {
	if [ ! -z "$1" ] && [ -d "$GOPATH/src/github.com/$1" ]; then
	  cd "$GOPATH/src/github.com/$1"
	elif [ ! -z "$1" ] && [ -d "$GOPATH/src/bitbucket.org/$1" ]; then
	  cd "$GOPATH/src/bitbucket.org/$1"
	elif [ ! -z "$1" ] && [ -d "$GOPATH/src/gitserver.trifecta.com/$1" ]; then
	  cd "$GOPATH/src/gitserver.trifecta.com/$1"
	elif [ ! -z "$1" ] && [ -d "$GOPATH/src/null/$1" ]; then
	  cd "$GOPATH/src/null/$1"
	elif [ ! -z "$1" ] && [ -s "$GOPATH/src/$1" ]; then
	  cd "$GOPATH/src/$1"
	else
	  cd "$PROJECTS/$1"
	fi
}
