# Moves all of the files into the correct place for their configuration.
#
# Usage
# ./setup.sh
#
# Installs at the default location (~)
#
# ./setup.sh target_dir
#
# Sets the files up with the root at the specified directory


BASEDIR=$(cd "$(dirname $0)" && pwd)
TARGET_DIR=${1:-~}
# Running example
#Installs stuff
ln -nsf $BASEDIR/bash/.bashrc $TARGET_DIR/.bashrc
ln -nsf $BASEDIR/bash/git-prompt.sh $TARGET_DIR/git-prompt.sh
ln -nsf $BASEDIR/tmux/.tmux.conf $TARGET_DIR/.tmux.conf
mkdir -p $TARGET_DIR/.config/alacritty
ln -nsf $BASEDIR/alacritty/alacritty.toml $TARGET_DIR/.config/alacritty/alacritty.toml
ln -nsf $BASEDIR/nvim $TARGET_DIR/.config/nvim
ln -nsf $BASEDIR/zsh/zshrc $TARGET_DIR/.zshrc
ln -nsf $BASEDIR/zsh/zshprofile $TARGET_DIR/.zshprofile
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
