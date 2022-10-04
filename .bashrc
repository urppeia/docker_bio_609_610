alias today="date '+%Y%m%d'"

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
PS1='\[\e[0;31m\]\u in \h\[\e[m\] \[\e[0;37m\]\w\[\e[m\] \[\e[0;32\] \[\e[m\]\[\e[0;33m\]$(parse_git_branch)\[\033[00m\]\n\$  '

DISABLE_AUTO_TITLE=true

alias ls='ls --color'
