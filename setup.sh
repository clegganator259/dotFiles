BASEDIR=$(cd "$(dirname $0)" && pwd)
#Installs stuff
ln -nsf $BASEDIR/bash/.bashrc $1/.bashrc
ln -nsf $BASEDIR/bash/git-prompt.sh $1/git-prompt.sh
ln -nsf $BASEDIR/tmux/.tmux.conf $1/.tmux.conf
ln -nsf $BASEDIR/alacritty/alacritty.yml $1/.config/alacritty/alacritty.yml
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
