alias ls='ls --color=auto'
alias ll='ls -la --color=auto'
alias la='ll'
alias y='yaourt'
alias ys='yaourt -Ss'
alias yi='yaourt -S'
alias yin='yi --noconfirm'
alias yu='yaourt -Syua'
alias yun='yu --noconfirm'
alias yunf='yun --force'
alias yp='yaourt -Qm'
alias yr='yaourt -R'
alias wgup='sudo wg-quick up wg0-client'
alias wgdown='sudo wg-quick down wg0-client'
alias ovpnup='systemctl start openvpn-client@streisand.service'
alias ovpndown='systemctl stop openvpn-client@streisand.service'
alias mountWindows='sudo mount /dev/sda4 /windows'
alias emptyTrash='rm -rf ~/.local/share/Trash/*'
alias dotfiles='(cd ~/dotfiles && vim -c NERDTree)'
alias grep="grep --color=auto"
alias restartX="systemctl restart lightdm"
alias mit-scheme="rlwrap -r -c -f ~/dotfiles/config/mit-scheme/mit_scheme_bindings.txt mit-scheme"
alias scheme="rlwrap -r -c -f ~/dotfiles/config/mit-scheme/mit_scheme_bindings.txt mit-scheme"
