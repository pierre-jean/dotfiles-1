#!/bin/bash

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

if [ -d ~/.before_startx ] ; then
 for f in ~/.before_startx/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Start X
exec i3
