#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

export EDITOR=vim
export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json

xrdb -merge ~/.Xresources

exec awesome
#exec startxfce4
