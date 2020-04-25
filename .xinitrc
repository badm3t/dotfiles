#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

export EDITOR=vim

xrdb -merge ~/.Xresources

#exec feh --bg-fill /media/hdd2/pics/wallhaven-oxe8op.jpg &
#exec dwm

exec awesome

#while true; do
#  /usr/local/bin/dwm 2> /dev/null
#done
