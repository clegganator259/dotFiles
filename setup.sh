BASEDIR=$(cd "$(dirname $0)" && pwd)
TARGET_DIR=${1:-~}
# Running example
#Installs stuff
ln -nsf $BASEDIR/bash/.bashrc $TARGET_DIR/.bashrc
ln -nsf $BASEDIR/bash/git-prompt.sh $TARGET_DIR/git-prompt.sh
ln -nsf $BASEDIR/tmux/.tmux.conf $TARGET_DIR/.tmux.conf
ln -nsf $BASEDIR/alacritty/alacritty.yml $TARGET_DIR/.config/alacritty/alacritty.yml
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
