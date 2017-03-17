BASEDIR=$(cd "$(dirname $0)" && pwd)
#Installs stuff
ln -nsf $BASEDIR/vim/.vimrc $1/.vimrc
ln -nsf $BASEDIR/Xconfig/.Xresources $1/.Xresources
ln -nsf $BASEDIR/bash/.bashrc $1/.bashrc
ln -nsf $BASEDIR/vim/.vimrc $1/.vimrc
ln -nsf $BASEDIR/tmux/.tmux.conf $1/.tmux.conf
ln -nsf $BASEDIR/Xconfig/.xprofile $1/.xprofile
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
vim +PluginInstall +qall
