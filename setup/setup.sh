#!/usr/bin/env bash
set -e

ask() {
  # https://djm.me/ask
  local prompt default reply

  while true; do

    if [ "${2:-}" = "Y" ]; then
      prompt="Y/n"
      default=Y
    elif [ "${2:-}" = "N" ]; then
      prompt="y/N"
      default=N
    else
      prompt="y/n"
      default=
    fi

    # Ask the question (not using "read -p" as it uses stderr not stdout)
    echo -n "$1 [$prompt] "

    # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
    read reply </dev/tty

    # Default?
    if [ -z "$reply" ]; then
      reply=$default
    fi

    # Check if the reply is valid
    case "$reply" in
      Y*|y*) return 0 ;;
      N*|n*) return 1 ;;
    esac

  done
}

installi3() {
  echo "Installing i3 and required tools"
  sleep 2
  yaourt --noconfirm -S ./yaourt_i3.txt

  # Default thunar to file directories
  #gvfs-mime --set inode/directory thunar.desktop
  #xdg-mime default thunar.desktop inode/directory

  ln -sfn "${dir}/config/i3 ${HOME}/.config/i3"

  # gsimplecal configuration
  [ -d "${HOME}/.config/gsimplecal" ] || mkdir -p "${HOME}/.config/gsimplecal"
  ln -sfn "${dir}/config/gsimplecal/config" "${HOME}/.config/gsimplecal/config"

  #i3blocks
  ln -sfn "$dir/config/i3blocks/config" "$HOME/.i3blocks.conf"
  yaourt --noconfirm -S sysstat ponymix
}

installFonts() {
  echo "Installing fonts"
  sleep 2
  yaourt --noconfirm -S ./yaourt_fonts.txt
  mkdir -p ~/.config/fontconfig/conf.d/

  # Set font fallback configuration in place
  ln -sfn "${dir}/config/fontconfig/10-icons.conf" "${HOME}/.config/fontconfig/conf.d/10-icons.conf"

  # Refresh user and global font paths
  fc-cache -fv
  sudo fc-cache -fv

  # Install vcconsole.font & colors
  yaourt --noconfirm -S mkinitcpio-colors-git
  cp "${dir}/config/fontconfig/vconsole.conf" /etc/

  sudo sed -i /etc/mkinitcpio.conf -e 's/^\\\(HOOKS=\"base\s\)\([^\"]\+\)\"/\1colors consolefont \2"/'
  sudo mkinitcpio -p linux
}

installThemes() {
  echo "Installing themes"
  sleep 2
  yaourt --noconfirm -S ./yaourt_themes.txt
}

installJava() {
  echo "Installing Java"
  yaourt --noconfirm -S ./yaourt_java.txt
}

installAndroid() {
  echo "Installing Android"
  yaourt --noconfirm -S ./yaourt_android.txt
}

installScala() {
  echo "Installing Scala"
  yaourt --noconfirm -S ./yaourt_scala.txt
}

installGit() {
  echo "Installing Git"
  yaourt --noconfirm -S ./yaourt_git.txt
  ln -sfn "${dir}/.gitconfig" "${HOME}/.gitconfig"
  gibo Emacs Vim JetBrains Tags Vagrant Windows macOS Linux Archives >> ~/.gitignore.global
}

installDocker() {
  echo "Installing Docker"
  yaourt --noconfirm -S \
    docker

  #Setup Docker
  sudo systemctl start docker
  sudo systemctl enable docker
  sudo usermod -aG docker carlos
}

installTerragrunt() {
  echo "Installing Terraform & Terragrunt"
  yaourt --noconfirm -S \
    terraform

  #Terragrunt
  curl -s https://api.github.com/repos/gruntwork-io/terragrunt/releases | grep browser_download_url | head -n 4 | cut -d '"' -f 4 | grep "linux_386"
  sudo mv ./terragrunt_linux_386 /usr/bin/terragrunt
}

installHaskell() {
  wget -qO- https://get.haskellstack.org/ | sh

  stack setup
  stack install ghc-mod hindent cabal-install hoogle hdevtools hlint apply-refact stylish-haskell intero
  cabal update
  echo "========"
  echo "Your GHC path will be: $(stack path | grep ghc-paths)"
  echo "========"
}

installIntellij() {
  echo "Installing IntelliJ"
  yaourt --noconfirm -S \
    intellij-idea-ce

  #IntelliJ watches in the FS
  sudo bash -c 'echo "fs.inotify.max_user_watches = 524288" > /etc/sysctl.d/99-sysctl.conf'
  sudo sysctl --system
}

installDevTools() {
  echo "Installing developer tools"
  sleep 2
  installJava
  installAndroid
  installScala
  installDocker
  installTerragrunt
  installIntellij
  installWeb
  installHaskell
  pinstallAwsCli
}

installTools() {
  echo "Installing apps and tools"
  sleep 2
  yaourt --noconfirm -S ./yaourt_tools.txt
  installVariety

  #urxvt
  yaourt --noconfirm -S rxvt-unicode rxvt-unicode-terminfo urxvt-perls urxvt-resize-font-git

  #powerline
  yaourt --noconfirm -S powerline
  wget https://github.com/rdnetto/powerline-hs/releases/latest -O ~/.local/bin/powerline-hs
  mkdir "$HOME/.config/powerline/"
  ln -sfn "$dir/config/powerline/*" "$HOME/.config/powerline"

  # Patcher matcher as described in
  # https://wiki.archlinux.org/index.php/Rxvt-unicode#Very_long_lines_cause_slowdown
  mkdir -p "$HOME/.urxvt"
  ln -sfn "$dir/config/urxvt/matcher" "$HOME/.urxvt/ext/matcher"

   # Network Manager DNS setup
   yaourt --noconfirm -S openresolv
   sudo ln -sfn "$dir/config/networkmanager/rc-manager.conf" "/etc/NetworkManager/conf.d/rc-manager.conf"
   sudo ln -sfn "$dir/config/networkmanager/resolvconf.conf" "/etc/resolvconf.conf"
}

installXresources() {
  ln -sfn "$dir/config/Xresources/Xresources" "$HOME/.Xresources"
  ln -sfn "$dir/config/Xresources/Xdefaults" "$HOME/.Xdefaults"
  ln -sfn "$dir/config/Xresources/xcolors" "$HOME/.xcolors"
  ln -sfn "$dir/config/urxvt/xurxvt" "$HOME/.xurxvt"
  ln -sfn "$dir/config/simpleterminal/xst" "$HOME/.xst"
}


installVariety() {
  yaourt --noconfirm -S variety
  ln -sfn ~/dotfiles/config/variety/config ~/.config/variety/variety.conf
  sudo chmod a+w /usr/share/backgrounds/
}

installRedshift() {
  echo "Installing redshift"
  sleep 2
  yaourt --noconfirm -S redshift
  [ -d "${HOME}/.config/redshift" ] || mkdir -p "${HOME}/.config/redshift"
  ln -sfn "{dir}/config/redshift/config" "${HOME}/.config/redshift/config"
}

installScreensavers() {
  echo "Installing screensavers"
  sleep 2
  yaourt --noconfirm -S nyancat
}

installPacman() {
  sudo rm /etc/pacman.conf
  ln -sfn "${dir}/config/pacman/pacman.conf" /etc/pacman.conf
  sudo pacman-key --init
  sudo pacman-key --populate archlinux
  sudo pacman -Syu
}

installYaourt() {
  installPacman
  sudo pacman -S --needed base-devel git wget yajl
  wget https://aur.archlinux.org/cgit/aur.git/snapshot/package-query.tar.gz
  tar xvfz package-query.tar.gz
  cd package-query
  makepkg -si
  cd ..
  rm -rf package-query
  rm package-query.tar.gz
  wget https://aur.archlinux.org/cgit/aur.git/snapshot/yaourt.tar.gz
  tar xvfz yaourt.tar.gz
  cd yaourt
  makepkg -si
  cd ..
  rm -rf yaourt
  rm yaourt.tar.gz
}

installVim() {
  yaourt -S --noconfirm gvim
  #Install plugin system
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  ln -sfn "${dir}/.vimrc" "${HOME}/.vimrc"
  mkdir -p ~/.vim.backup
  mkdir -p ~/.vim.tmp
  #Require for ferret plugin to work (search text across files)
  yaourt -S --noconfirm the_silver_searcher
  vim +PluginInstall +qall
}

installEmacs() {
  mkdir -p "$HOME/.emacs.d/"
  # Install like this until emacs 26 is released in aur
  (cd "$dir/config/emacs/install/" && makepkg -si)
  mkdir -p "$HOME/.emacs.saves"
  mkdir -p "$HOME/.emacs.undo"
  touch "$HOME/.emacs.d/custom.el"

  ln -sfn "$dir/config/emacs/init.el" "$HOME/.emacs.d/"
  ln -sfn "$dir/config/emacs/lisp/" "$HOME/.emacs.d/lisp"
  ln -sfn "$dir/config/emacs/snippets/" "$HOME/.emacs.d/snippets"

  mkdir -p "$HOME/.config/systemd/user"
  ln -sfn "$dir/config/units/emacs.service" "$HOME/.config/systemd/user/emacs.service"
  systemctl --user enable --now emacs
}

installRanger() {
  yaourt -S ranger --noconfirm
  ln -sfn "$dir/config/ranger/config" "$HOME/.config/ranger/rc.conf"
  ln -sfn "$dir/config/ranger/scope.sh" "$HOME/.config/ranger/scope.sh"
  ln -sfn "$dir/config/ranger/commands/py" "$HOME/.config/ranger/commands.py"
}

installMutt() {
  yaourt -S --noconfirm neomutt
  ln -sfn "$dir/config/mutt/.muttrc" "$HOME/.muttrc"
}

installKhal() {
  yaourt -S --noconfirm khal vdirsyncer

  mkdir -p "$HOME/.config/khal"
  mkdir -p "$HOME/.config/vdirsyncer"

  ln -sfn "$dir/config/khal/khal.conf" "$HOME/.config/khal/khal.conf"
  cp "$dir/config/khal/vdirsyncerconfig" "$HOME/.config/vdirsyncer/config"
=======
  ln -sfn "$dir/config/ranger/config" "$HOME/.config/ranger/rc.conf"
  ln -sfn "$dir/config/ranger/scope.sh" "$HOME/.config/ranger/scope.sh"
}

installMutt() {
  yaourt -S --noconfirm neomutt
  ln -sfn "$dir/config/mutt/.muttrc" "$HOME/.muttrc"
}

installKhal() {
  yaourt -S --noconfirm khal vdirsyncer

  mkdir -p "$HOME/.config/khal"
  mkdir -p "$HOME/.config/vdirsyncer"

  ln -sfn "$dir/config/khal/khal.conf" "$HOME/.config/khal/khal.conf"
  cp "$dir/config/khal/vdirsyncerconfig" "$HOME/.config/vdirsyncer/config"
>>>>>>> 6a76e30... Add ranger scope configuration to preview images
}

installAudio() {
  yaourt -S --noconfirm ./yaourt_audio.txt
  asoundconf set-default-card PCH
  asoundconf set-pulseaudio
}

installCompton() {
  yaourt -S --noconfirm \
    compton \
    xorg-xwininfo
  ln -sfn "${dir}/config/compton/compton.conf" "${HOME}/.config/compton.conf"
}

installLightDm() {
  yaourt -S --noconfirm \
    lightdm \
    lightdm-gtk-greeter \
    lightdm-webkit2-greeter
  ln -sfn "${dir}/.xprofile" "{HOME}/.xprofile"
  sudo ln -sfn "${dir}/config/lightdm/lightdm.conf" /etc/lightdm/lightdm.conf
  sudo systemctl enable lightdm.service
}

installAppsOnStartUp() {
  mkdir -p ~/.before_startx
  cp "${dir}/.before_startx/run.sh" ~/.before_startx/run.sh
  chmod a+x ~/.before_startx/run.sh
}
dir=$(pwd)
if [ ! -e "${dir}/${0}" ]; then
  echo "Script not called from within repository directory. Aborting."
  exit 2
fi
dir="${dir}/.."

echo "PaNaVTEC dotfiles installer"
# Makes dir for scrot screenshots
[ -d "${HOME}/Pictures/Screenshots" ] || mkdir -p "${HOME}/Pictures/Screenshots"
[ -d "${HOME}/.data" ] || mkdir "${HOME}/.data"
[ -d "${HOME}/.i3" ] || mkdir "${HOME}/.i3"

#Makes binary executable
chmod a+x "${dir}/bin/*"

echo "actionSystem.suspendFocusTransferIfApplicationInactive=false add this into intelliJ to prevent focus lose"

installXresources;
ask "install yaourt?" Y && installYaourt;
ask "install i3?" Y && installi3;
ask "install compton?" Y && installCompton;
ask "install lightdm?" Y && installLightDm;
ask "install fonts?" Y && installFonts;
ask "install dev tools?" Y && installDevTools;
ask "install apps and tools?" Y && installTools;
ask "install themes?" Y && installThemes;
ask "install vim config?" Y && installVim;
ask "install emacs?" Y && installEmacs;
ask "install audio?" Y && installAudio;

ask "Install redshift + config?" Y && installRedshift
ask "Install symlink for .xinitrc?" Y && ln -sfn "${dir}/.xinitrc" "${HOME}/.xinitrc"
ask "Install symlink for .bashrc?" Y && \
  ln -sfn "$dir/.bashrc" "$HOME/.bashrc" && \
  ln -sfn "$dir/inputrc" "$HOME/.inputrc"
ask "Install symlink for .bash_profile?" Y && ln -sfn "${dir}/.bash_profile" "${HOME}/.bash_profile"

ask "Install configuration for bin?" Y && ln -sfn "${dir}/bin" "${HOME}/.bin"
ask "Install configuration for dunst?" Y && ln -sfn "${dir}/config/dunst" "${HOME}/.config/dunst"
ask "Install configuration for termite?" Y && ln -sfn "${dir}/config/termite" "${HOME}/.config/termite" && ln -sfn "${dir}/.dircolors" "${HOME}/.dircolors"
ask "Install screensavers?" Y && installScreensavers;
ask "Install Ranger" Y && installRanger;
ask "Install apps to launch on system boot" Y && installAppsOnStartUp;
