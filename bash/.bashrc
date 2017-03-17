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


wmctrl -r "urxvt -e tmux" -t 3
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
    cogs) cd ~/Documents/InventiveCogs ;;
    dotfiles) cd ~/DotFiles ;; 
    [0-9]) cd ${WAYPOINTS[$1]} ;;
    *) echo "No shortcut for" $1;;
  esac
}
alias jt=jumpto
