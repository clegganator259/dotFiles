#
# ~/.bashrc
#

[[ $- != *i* ]] && return

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

#####################################################################################
###                                 MY CONFIG                                     ###
#####################################################################################

export PS1="\[\e[1;32m\][\[\e[033m\]\t \[\e[1;32m\]\u@\h \[\e[0;36m\]\w\e[1;32m\]]\n \[\e[0;34m\]λ \[$(tput sgr0)\]"


#
# Adds and commits a single file
# arg1: the file to commit
# arg2: the commit message
#


export JAVA_HOME=/usr/lib/jvm/default
PATH="$HOME/bin:$PATH"

#####################################################################################
###                                 MY FUNCTIONS                                  ###
#####################################################################################

commit-file() {
  echo "committing message" $1 "with message" $2
  git add $1
  git commit -m "$2"
}

up() { 
  cd $(eval printf '../'%.0s {1..$1});
}

reconfig(){ 
  source ~/.bashrc;
  tmux source-file ~/.tmux.conf;
}

WAYPOINTS=(~ ~ ~ ~ ~ ~ ~ ~ ~ ~)

waypoint(){
  WAYPOINTS[$1]=`pwd`
}

jumpto(){
  case $1 in
    akommo) cd ~/Documents/akommo ;;
    admiral) cd ~/Documents/admiral ;;
    ardbeg) cd ~/Documents/ardbeg ;;
    eventhive) cd ~/Documents/eventhiveplus-concept ;;
    mwac) cd ~/Documents/mwac/mwac ;;
    native) cd ~/Documents/native-finance;;
    faq) cd ~/Documents/faq;;
    admin) cd ~/Documents/admin/cotidia/admin;;
    account) cd ~/Documents/account/cotidia/account;;
    socialshare) cd ~/Documents/social-share/cotidia/socialshare;;
    magicw) cd ~/Documents/magicw ;;
    stationery) cd ~/Documents/magic-whiteboard-stationery ;;
    exotic) cd ~/Documents/exoticdirect ;;
    mandala) cd ~/Documents/mandala ;;
    dotfiles) cd ~/DotFiles ;; 
    [0-9]) cd ${WAYPOINTS[$1]} ;;
    *) echo "No shortcut for" $1;;
  esac
}
# Bash related aliases
alias bashrc="vim ~/.bashrc && reconfig"
alias vimrc="vim ~/.vimrc && reconfig"
alias tmuxrc="vim ~/.tmux.conf && reconfig"
alias jt=jumpto
alias pls='sudo "$BASH" -c "$(history -p !!)"'

# Note taking aliases
n() {
    title="$*"
    title_slug=`sed -e "s/ /_/g" <<< "$title"`
    filename=~/notes/"[`date '+%Y-%m-%d %H:%M'`]$title_slug".md
    echo "## [`date '+%Y-%m-%d %H:%M'`] $title" > "$filename"
    vim "$filename"
    echo -e "\n" >> "$filename"
}

ncat() {
    mdless ~/notes/*
}

nls() {
    ls -c ~/notes/ | grep "$*"

}

# Virtualenv aliases
alias avenv=". ./venv/bin/activate"
alias mvenv="virtualenv venv"
alias dvenv="deactivate"

# Django aliases

function django {
    avenv; python manage.py $@; dvenv
}

function dmr {
    avenv; django runserver $@; dvenv
}

function dms {
    avenv; django shell $@
}

function dmt {
    avenv && django test -k $@; dvenv
}

function dmt-k {
    avenv && django test $@; dvenv
}

function tadd {
    task add project:$@
}

function tlog {
    task log project:$@
}

function tlist {
    if [ $# -eq 0 ]
    then
        task list
    else
        task list project:$@
    fi

}

function tcomplete {
    if [ $# -eq 0 ]
    then
        task completed
    else
        task completed project:$@
    fi

}

function tdone {
    task $@ done
}

function git-cleanup {
    git_branch="$(git rev-parse --abbrev-ref HEAD)"
    read -p "To confirm type the current branch name ($git_branch): " user_branch
    if [ "$user_branch" == "$git_branch" ]
    then
        git branch --merged | egrep -v "(^\*|master|dev|develop)" | xargs git branch -d
    else
        echo "Cancelled"
    fi
}

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# GO bindings
# Adds go to path
export GOROOT=$HOME/go
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:/usr/local/go/bin

