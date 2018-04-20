DOTFILES_LOCATION=$HOME/dotfiles

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
alias wgCoduranceUp='sudo wg-quick up codu-client'
alias wgCoduranceDown='sudo wg-quick down codu-client'
alias ovpnup='systemctl start openvpn-client@streisand.service'
alias ovpndown='systemctl stop openvpn-client@streisand.service'
alias mountWindows='sudo mount /dev/sda4 /windows'
alias emptyTrash='rm -rf ~/.local/share/Trash/*'
alias dotfiles='(cd "$DOTFILES_LOCATION" && emacs -nw)'
alias grep='grep --color=auto'
alias restartX='systemctl restart lightdm'
alias mit-scheme='rlwrap -r -c -f ~/dotfiles/config/mit-scheme/mit_scheme_bindings.txt mit-scheme'
alias scheme='rlwrap -r -c -f ~/dotfiles/config/mit-scheme/mit_scheme_bindings.txt mit-scheme'
alias exa='exa -bghlaU --git --group-directories-first'
alias weather='curl wttr.in/~London'
alias ffs='sudo $(fc -ln -1)'
alias et='emacsclient -nw'
alias ew='emacsclient'
alias e='emacs -nw'
alias yarn='yarn --emoji'
alias ya='yarn --emoji'

alias yu='systemUpdate;'
alias yun='systemUpdate "--noconfirm";'
alias yunf='yun --force'
alias fixEmacs='sudo pacman -U /var/cache/pacman/pkg/librsvg-2\:2.42.2-1-x86_64.pkg.tar.xz'
alias shortcuts="$DOTFILES_LOCATION/config/shortcuts/shortcuts.sh"

systemUpdate () {
  echo "Upgrading system packages"
  yaourt -Syua "$1"

  echo "Updating dotfiles"
  (cd "$DOTFILES_LOCATION" && git pull)

  echo "Upgrade completion package"
  sudo curl -o "/usr/local/bin/yarn-completion.bash" https://raw.githubusercontent.com/dsifford/yarn-completion/master/yarn-completion.bash
  sudo curl -o "/usr/local/bin/git-completion.bash" https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
}
