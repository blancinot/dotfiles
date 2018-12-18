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

# source bash completion
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# source bash_aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

xhost +local:root > /dev/null 2>&1
complete -cf sudo

shopt -s expand_aliases

# History stff
# append to the history file, don't overwrite it
shopt -s histappend
# Combine multiline commands into one in history
shopt -s cmdhist
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

export HISTCONTROL=ignoreboth
export HISTSIZE=20000
export HISTFILESIZE=20000
export HISTIGNORE='&:ls:ll:la:cd:exit:clear:history'

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}


# Display git branch
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[:\1] /'
}

# color for prompt
RED='\[\033[0;31m\]'
YELLOW='\[\033[0;33m\]'
GREEN='\[\033[0;32m\]'
BLUE='\[\033[0;34m\]'
LIGHT_RED='\[\033[1;31m\]'
LIGHT_GREEN='\[\033[1;32m\]'
CYAN='\[\033[0;36m\]'
WHITE='\[\033[1;37m\]'
LIGHT_GRAY='\[\033[0;37m\]'
COLOR_NONE='\[\e[0m\]'

#COLOR PS1
COLOR_LINE=${YELLOW}
COLOR_DATE=${LIGHT_RED}
COLOR_USER=${CYAN}
COLOR_AT=${YELLOW}
COLOR_MACHINE=${BLUE}
COLOR_PWD=${LIGHT_GRAY}
COLOR_GIT=${YELLOW}

PS1="${debian_chroot:+($debian_chroot)}\n${COLOR_LINE}┌┤${COLOR_DATE}\t${COLOR_LINE} - ${COLOR_USER}\u${COLOR_AT}@${COLOR_MACHINE}\h${COLOR_LINE} - ${COLOR_GIT}\$(parse_git_branch)${COLOR_PWD}\w ${COLOR_LINE}\n${COLOR_LINE}└━┤${COLOR_NONE} "


# better yaourt colors
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"
