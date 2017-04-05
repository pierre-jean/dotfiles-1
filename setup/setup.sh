#!/usr/bin/env bash
set -e

ask() {
  # http://djm.me/ask
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

    # ask the question
    read -p "$1 [$prompt] " REPLY

    # default?
    if [ -z "$REPLY" ]; then
      REPLY=$default
    fi

    # check if the reply is valid
    case "$REPLY" in
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

  ln -sfn ${dir}/config/i3 ${HOME}/.config/i3

  # gsimplecal configuration
  [ -d ${HOME}/.config/gsimplecal ] || mkdir -p ${HOME}/.config/gsimplecal
  ln -sfn ${dir}/config/gsimplecal/config ${HOME}/.config/gsimplecal/config

  # polybar
  ln -sfn ${dir}/config/polybar/config ${HOME}/.config/polybar

}

installFonts() {
  echo "Installing fonts"
  sleep 2
  yaourt --noconfirm -S ./yaourt_fonts.txt
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

installClojure() {
  echo "Installing Clojure"
  yaourt --noconfirm -S ./yaourt_clojure.txt
}

installGit() {
  echo "Installing Git"
  yaourt --noconfirm -S ./yaourt_git.txt
  ln -sfn ${dir}/.gitconfig ${HOME}/.gitconfig
  gibo Vim JetBrains Tags Vagrant Windows macOS Linux Archives >> ~/.gitignore.global
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

installIntellij() {
  echo "Installing IntelliJ"
  yaourt --noconfirm -S \
    intellij-idea-ce

  #IntelliJ watches in the FS
  sudo bash -c 'echo "fs.inotify.max_user_watches = 524288" > /etc/sysctl.d/99-sysctl.conf'
  sudo sysctl --system
}

installWeb() {
  npm install -g jshint
  npm install -g eslint
}

installDevTools() {
  echo "Installing developer tools"
  sleep 2
  installJava
  installAndroid
  installScala
  installClojure
  installDocker
  installTerragrunt
  installIntellij
  installWeb
  installAwsCli
}

installAwsCli() {
  pip install --upgrade --user awscli
}

installTools() {
  echo "Installing apps and tools"
  sleep 2
  yaourt --noconfirm -S ./yaourt_tools.txt
}

installRedshift() {
  echo "Installing redshift"
  sleep 2
  yaourt --noconfirm -S redshift
  [ -d ${HOME}/.config/redshift ] || mkdir -p ${HOME}/.config/redshift
  ln -sfn ${dir}/config/redshift/config ${HOME}/.config/redshift/config
}

installScreensavers() {
  echo "Installing screensavers"
  sleep 2
  yaourt --noconfirm -S nyancat
}

installYaourt() {
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
  #init keyring
  sudo pacman-key --init
  sudo pacman-key --populate archlinux
}

installVim() {
  yaourt -S --noconfirm gvim
  #Install plugin system
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  ln -sfn ${dir}/.vimrc ${HOME}/.vimrc
  mkdir -p ~/.vim.backup
  mkdir -p ~/.vim.tmp
  #Require for ferret plugin to work (search text across files)
  yaourt -S --noconfirm the_silver_searcher
  vim +PluginInstall +qall
}

installRanger() {
  yaourt -S ranger --noconfirm
  ranger --copy-config=scope
  ln -sfn ${dir}/config/ranger/config ${HOME}/.config/ranger/rc.conf
}

installKhal() {
  sudo pip install khal
  sudo pip install vdirsyncer
  sudo pip install requests-oauthlib

  [ -d ${HOME}/.config/khal ] || mkdir -p ${HOME}/.config/khal
  [ -d ${HOME}/.config/vdirsyncer ] || mkdir -p ${HOME}/.config/vdirsyncer

  ln -sfn ${dir}/config/khal/khal.conf ${HOME}/.config/khal/khal.conf
  cp ${dir}/config/khal/vdirsyncerconfig ${HOME}/.config/vdirsyncer/config
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
  ln -sfn ${dir}/config/compton/compton.conf ${HOME}/.config/compton.conf
}

installAppsOnStartUp() {
  mkdir -p ~/.before_startx
  cp ${dir}/.before_startx/run.sh ~/.before_startx/run.sh
  chmod a+x ~/.before_startx/run.sh
}
dir=`pwd`
if [ ! -e "${dir}/${0}" ]; then
  echo "Script not called from within repository directory. Aborting."
  exit 2
fi
dir="${dir}/.."

echo "PaNaVTEC dotfiles installer"
# Makes dir for scrot screenshots
[ -d ${HOME}/Pictures/Screenshots ] || mkdir -p ${HOME}/Pictures/Screenshots
[ -d ${HOME}/.data ] || mkdir ${HOME}/.data
[ -d ${HOME}/.i3 ] || mkdir ${HOME}/.i3

#Makes binary executable
chmod a+x ${dir}/bin/*

#TODO: this autommagically
echo "Remember that you need to uncommed the [multilib] repo in /etc/pacman.conf, if you haven't done that, please modify that file, update with pacman -Syua and come back later"
echo "actionSystem.suspendFocusTransferIfApplicationInactive=false add this into intelliJ to prevent focus lose"

ask "install yaourt?" Y && installYaourt;
ask "install i3?" Y && installi3;
ask "install compton?" Y && installCompton;
ask "install fonts?" Y && installFonts;
ask "install dev tools?" Y && installDevTools;
ask "install apps and tools?" Y && installTools;
ask "install themes?" Y && installThemes;
ask "install vim config?" Y && installVim;
ask "install audio?" Y && installAudio;

ask "Install redshift + config?" Y && installRedshift
ask "Install symlink for .xinitrc?" Y && ln -sfn ${dir}/.xinitrc ${HOME}/.xinitrc
ask "Install symlink for .bashrc?" Y && ln -sfn ${dir}/.bashrc ${HOME}/.bashrc
ask "Install symlink for .bash_profile?" Y && ln -sfn ${dir}/.bash_profile ${HOME}/.bash_profile

ask "Install configuration for bin?" Y && ln -sfn ${dir}/bin ${HOME}/.bin
ask "Install configuration for dunst?" Y && ln -sfn ${dir}/config/dunst ${HOME}/.config/dunst
ask "Install configuration for termite?" Y && ln -sfn ${dir}/config/termite ${HOME}/.config/termite && ln -sfn ${dir}/.dircolors ${HOME}/.dircolors;
ask "Install screensavers?" Y && installScreensavers;
ask "Install Ranger" Y && installRanger;
ask "Install Khal" Y && installKhal;
ask "Install apps to launch on system boot" Y && installAppsOnStartUp;
