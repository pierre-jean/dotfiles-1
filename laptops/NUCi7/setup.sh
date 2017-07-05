yaourt --noconfirm -S  \
  xf86-video-intel

bash -c 'echo -e "options snd-hda-intel model=dell-headset-multi" > /etc/modprobe.d/alsa-base.conf'

# Intel driver
sudo cp 20-intel.conf /etc/X11/xorg.conf.d/20-synaptics.conf
