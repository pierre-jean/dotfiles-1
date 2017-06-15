# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# use gtk for java apps
# export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

export XDG_CONFIG_HOME=$HOME/.config
export JAVA8_HOME=/usr/lib/jvm/java-8-jdk/
export BROWSER=google-chrome-stable
export EDITOR=vim
export TERRAGRUNT_TFPATH=/usr/bin/terraform
export ORION_PEM_LOCATION=~/.ssh/orion.pem
export GREP_OPTIONS='--color=always'

source ~/dotfiles/prompt.sh
source ~/dotfiles/git-completion.bash
source ~/dotfiles/git-alias.sh
source ~/dotfiles/functions.sh
source ~/dotfiles/alias.sh
source ~/dotfiles/paths.sh
source ~/.env.sh

# Needed for autojump to work
source /etc/profile.d/autojump.bash

# Enable autocd
shopt -s autocd

# Use omtc in firefox (enables html5 youtube hi quality videos)
export MOZ_USE_OMTC=1

# Set keyboard to US
setxkbmap -layout us -variant altgr-intl -option nodeadkeys

# Set dir colors
eval $(dircolors ~/.dircolors)

# Limit prompt dirs depth 
PROMPT_DIRTRIM=2

#Increase history size
HISTFILESIZE=1000000000
HISTSIZE=1000000
