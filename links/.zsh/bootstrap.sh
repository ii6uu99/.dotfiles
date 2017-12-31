#!/bin/sh

# We suppose you have already cloned ~/.zsh

# Get oh-my-zsh
if [ ! -e ~/.vim/oh-my-zsh ]
then 
    git clone https://github.com/robbyrussell/oh-my-zsh ~/.zsh/oh-my-zsh
fi

cp ~/.zsh/cyrobin.zsh-theme ~/.zsh/oh-my-zsh/themes/

# Create a backup of the old zshrc / zshenv /zprofile if needed. 
# Make appropriate links.
if [ -f ~/.zshrc ]
    then mv ~/.zshrc ~/.zshrc.$(date +%s).bak
fi
echo "source ~/.zsh/zshrc" > ~/.zshrc

# zshenv
if [ -f ~/.zshenv ]
    then mv ~/.zshenv ~/.zshenv.$(date +%s).bak
fi
echo "source ~/.zsh/zshrc" > ~/.zshrc

# zprofile
if [ -f ~/.zprofile]
    then mv ~/.zprofile ~/.zprofile.$(date +%s).bak
fi
echo "source ~/.zsh/zprofile" > ~/.zprofile

echo "Done."
