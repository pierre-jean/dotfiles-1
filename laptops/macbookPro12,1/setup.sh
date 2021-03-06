yaourt -R xorg-xbacklight
yaourt --noconfirm -S  \
	xf86-input-synaptics \
  kbdlight \
	bcwc-pcie-git \
	acpilight \
  mbpfan-git \
  xf86-video-intel

# Fix wifi connection flickering
sudo cp 40-ipv6.conf /etc/sysctl.d

# Acpi light permissions
sudo cp 90-backlight.rules /etc/udev/rules.d/90-backlight.rules

#Fixes dpi of i3
bash -c 'echo -e "xrandr --dpi 160\nxrdb -merge ~/.Xresources" >> ~/.before_startx/run.sh'
bash -c 'echo -e "Xft.dpi: 160.0" >> ~/.Xresources'

#Fns instead of media keys
sudo cp apple.conf /etc/modprobe.d/apple.conf

#Enable fan service
sudo systemctl enable mbpfan.service
sudo systemctl start mbpfan.service

#Setup touchpad
sudo cp 70-synaptics.conf /etc/X11/xorg.conf.d/70-synaptics.conf

# Alsa Audio
asoundconf set-default-card PCH
asoundconf set-pulseaudio
sudo cp sound.conf /etc/modprobe.d/sound.conf

# Intel driver
sudo cp 20-intel.conf /etc/X11/xorg.conf.d/20-synaptics.conf
