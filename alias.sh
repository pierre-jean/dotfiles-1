dotfilesLocation=~/dotfiles

alias ls='ls --color=auto'
# alias ll='ls -lah --color=auto'
alias ll=exa
alias la='ll'
alias y='yaourt'
alias ys='yaourt -Ss'
alias yl='yaourt -Q'
alias yi='yaourt -S'
alias yin='yi --noconfirm'
alias yp='yaourt -Qm'
alias yr='yaourt -R'
alias wgup='sudo wg-quick up wg0-client'
alias wgdown='sudo wg-quick down wg0-client'
alias ovpnup='systemctl start openvpn-client@streisand.service'
alias ovpndown='systemctl stop openvpn-client@streisand.service'
alias mountWindows='sudo mount /dev/sda4 /windows'
alias emptyTrash='rm -rf ~/.local/share/Trash/*'
alias dotfiles='(cd "$dotfilesLocation" && vim -c NERDTree)'
alias grep='grep --color=auto'
alias restartX='systemctl restart lightdm'
alias mit-scheme='rlwrap -r -c -f ~/dotfiles/config/mit-scheme/mit_scheme_bindings.txt mit-scheme'
alias scheme='rlwrap -r -c -f ~/dotfiles/config/mit-scheme/mit_scheme_bindings.txt mit-scheme'
alias exa='exa -bghlaU --git --group-directories-first'
alias weather='curl wttr.in/~London'
alias ffs='sudo $(fc -ln -1)'
alias et='emacsclient -nw'
alias ew='emacsclient'
alias e='emacsclient'
alias yarn='yarn --emoji'
alias ya='yarn --emoji'

alias yu='systemUpdate;'
alias yun='systemUpdate "--noconfirm";'
alias yunf='yun --force'
alias fixEmacs='sudo pacman -U /var/cache/pacman/pkg/librsvg-2\:2.42.2-1-x86_64.pkg.tar.xz'

systemUpdate () {
  echo "Updating dotfiles"
  (cd "$dotfilesLocation" && git pull)
  yaourt -Syua "$1"
}
