alias ls='ls --color=auto'
alias ll='ls -la --color=auto'
alias la='ll'
alias manupdate='sudo systemctl start man-db.service'
alias ccat='pygmentize -g'
alias ccatl='pygmentize -g -O style=colorful,linenos=1'
alias wear_emulator='adb -d forward tcp:5601 tcp:5601'
alias wear_device='adb forward tcp:4444 localabstract:/adb-hub; adb connect localhost:4444'
alias y='yaourt'
alias ys='yaourt -Ss'
alias yi='yaourt -S'
alias yu='yaourt -Syua'
alias yun='yu --noconfirm'
alias yunf='yun --force'
alias yp='yaourt -Qm'
alias yr='yaourt -R'

## Favourites directories
alias blog='cd ~/Repositories/Blog/carlosmchica.github.io'
alias site='cd ~/Repositories/Ruby/Codurance/site'
alias araback='cd ~/Repositories/Java/Ararauna-Backend'
alias arafront='cd ~/Repositories/JavaScript/Ararauna-Frontend' 
alias repositories='cd ~/Repositories'
alias dotfiles='cd ~/dotfiles'
alias mns='cd ~/Repositories/Java/mns
'
## Ararauna 
export TWITTER_CONSUMER_KEY='WdIQmqSsN1px1waGexenIJDDe'
export TWITTER_CONSUMER_SECRET='tlyCdKO6k958m1UzpU2ea81C30q53wToxo9Ymv55N5GEaYTNQG'
export DATABASE_NAME='heroku_wmzjzp0s'
export JWT_SIGNING_KEY='tlyCdKO6k958m1UzpU2ea81C30q53wToxo9Ymv55N5GEaYTNQG'\
##

javaProject () { 
	gradle init --type java-library
	sed '$itestCompile "org.mockito:mockito-all:1.10.19"' build.gradle >> build.gradle
	gradle --refresh-dependencies
}

scalaProject () { 
	 gradle init --type scala-library
}

every() {
	watch -c -n $1 $2
}
