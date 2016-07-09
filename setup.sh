BASEDIR=$(cd "$(dirname $0)" && pwd)
pacman -S i3 --noconfirm
pacman -S dmenu --noconfirm
pacman -S vim --noconfirm
pacman -S rxvt-unicode --noconfirm
ln -nsf $BASEDIR/i3 $1/.config
ln -nsf $BASEDIR/vim/.vimrc $1/.vimrc
ln -nsf $BASEDIR/Xconfig/.Xresources $1/.Xresources
ln -nsf $BASEDIR/Xconfig/.xprofile $1/.xprofile
ln -nsf $BASEDIR/urxvt/clipboard /usr/lib/urxvt/perl/clipboard
