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
alias yin='yi --noconfirm'
alias pu="sudo pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 sudo pip install -U"
alias yu='pu && yaourt -Syua'
alias yun='yu --noconfirm'
alias yunf='yun --force'
alias yp='yaourt -Qm'
alias yr='yaourt -R'
alias wgup='sudo wg-quick up wg0-client'
alias wgdown='sudo wg-quick down wg0-client'
alias ovpnup='sudo openvpn /etc/openvpn/streisand.ovpn &'
alias ovpndown='sudo killall openvpn'

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
