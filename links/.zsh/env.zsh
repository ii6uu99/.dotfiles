# /etc/zsh/zshenv ou ~/.zshenv
# Fichier de configuration de zsh, lu au lancement de tout shell Zsh
# Formation Debian GNU/Linux par Alexis de Lattre
# http://formation-debian.via.ecp.fr/

# Le PATH = répertoires dans lequels le shell va chercher les commandes
# ATTENTION : le répertoire courant ne fait pas partie du PATH
export PATH="/usr/local/bin:/usr/local/sbin:/bin:/usr/bin:/usr/sbin:/usr/bin/X11:/usr/X11R6/bin:/usr/games:/sbin:$HOME/bin"

# Viewer/Editeur par defaut (pour Crontab, CVS,...)
export VISUAL=vim
export EDITOR=vim

# Permissions rw-r--r-- pour les fichiers crées
# et rwxr-xr-x pour les répertoires crées
umask 022

# Proxy HTTP / FTP sans mot de passe
#export http_proxy="http://proxy.exemple.org:8080"
#export ftp_proxy="ftp://proxy.exemple.org:8080"

# Proxy HTTP / FTP avec mot de passe
#export http_proxy="http://login:password@proxy.exemple.org:8080"
#export ftp_proxy="ftp://login:password@proxy.exemple.org:8080"

# Ne pas passer par le proxy pour les domaines locaux
#export no_proxy="exemple.org"

# De la couleur pour grep
export GREP_OPTIONS='--color=auto'

[ -z "STMUX" ] && export TERM=xterm-256color
export RUBY_HEAP_MIN_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_HEAP_FREE_MIN=500000
export EDITOR=vim

# Customize to your needs...
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/home/t/.rvm/bin
export LIBOVERLAY_SCROLLBAR=0
export XDG_RUNTIME_DIR=~/tmp



