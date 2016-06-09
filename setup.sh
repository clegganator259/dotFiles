pacman -S i3 --noconfirm
pacman -S dmenu --noconfirm
pacman -S vim --noconfirm
ln -nsf i3 $1/.config/i3
ln -nsf vim/.vimrc $1/.vimrc
ln -nsf Xconfig/.Xresources $1/.Xresources
ln -nsf Xconfig/.xprofile $1/.xprofile
