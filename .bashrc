# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# use gtk for java apps
# export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

## Ararauna 
export TWITTER_CONSUMER_KEY='WdIQmqSsN1px1waGexenIJDDe'
export TWITTER_CONSUMER_SECRET='tlyCdKO6k958m1UzpU2ea81C30q53wToxo9Ymv55N5GEaYTNQG'
export DATABASE_NAME='heroku_wmzjzp0s'
export JWT_SIGNING_KEY='tlyCdKO6k958m1UzpU2ea81C30q53wToxo9Ymv55N5GEaYTNQG'\
##

export XDG_CONFIG_HOME=$HOME/.config
export JAVA8_HOME=/usr/lib/jvm/java-8-jdk/
export BROWSER=google-chrome-stable
export EDITOR=vim
export TERRAGRUNT_TFPATH=/usr/bin/terraform

source ~/dotfiles/prompt.sh
source ~/dotfiles/git-completion.bash
source ~/dotfiles/git-alias.sh
source ~/dotfiles/functions.sh
source ~/dotfiles/alias.sh
source ~/dotfiles/paths.sh

# Use omtc in firefox (enables html5 youtube hi quality videos)
export MOZ_USE_OMTC=1

# Set keyboard to US
setxkbmap -layout us -variant altgr-intl -option nodeadkeys

eval $(dircolors ~/.dircolors)
