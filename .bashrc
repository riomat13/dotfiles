## If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# --------------------------------------
#  History
# --------------------------------------
# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000
HISTTIMEFORMAT="[%m/%d/%y %H:%M]  "
HISTIGNORE="&:ls:[bf]g:exit:history:clear:h:c:a"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# --------------------------------------
#  Import settings
# --------------------------------------
# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# python settings
if [ -f ~/.bash_py ]; then
    . ~/.bash_py
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

## Powerline
if [ -f /usr/share/powerline/bindings/bash/powerline.sh ]; then
    source /usr/share/powerline/bindings/bash/powerline.sh
fi

# ==========================================================
#  Functions
# ==========================================================
## extract data from compressed data
extract ()
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1    ;;
            *.tar.gz)    tar xvzf $1    ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xvf $1     ;;
            *.tbz2)      tar xvjf $1    ;;
            *.tgz)       tar xvzf $1    ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "don\'t know how to extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

# --------------------------------------
#  count files/directories
# --------------------------------------
fcnt()
{
    if [ -z "$2" ]; then
    N="$(find $1 -maxdepth 1 -type f | wc -l)";
    else
    N="$(find $1 -maxdepth 1 -type f -name $2 | wc -l)";
    fi
    if [ -z "$1" ] || [ "$1" == '.' ]; then path="./"; else path=$1; fi
    echo "$N files in $path";
}

fcntall()
{
    if [ -z "$2" ]; then
        N="$(find $1 -type f | wc -l)";
    else
        N="$(find $1 -type f -name $2 | wc -l)";
    fi
    if [ -z "$1" ] || [ "$1" == '.' ]; then path="./"; else path=$1; fi
    echo "$N files(total) in $path";
}

## count directories in given directory
dcnt()
{
    if [ -z "$2" ]; then
        N="$(find $1 -maxdepth 1 -not -path $1 -type d | wc -l)";
    else
        N="$(find $1 -maxdepth 1 -not -path $1 -type d -name $2 | wc -l)";
    fi
    if [ -z "$1" ] || [ "$1" == '.' ]; then path="./"; else path=$1; fi
    echo "$N directories in $path";
}

dcntall()
{
    if [ -z "$2" ]; then
        N="$(find $1 -not -path $1 -type d | wc -l)";
    else
        N="$(find $1 -not -path $1 -type d -name $2 | wc -l)";
    fi
    if [ -z "$1" ] || [ "$1" == '.' ]; then path="./"; else path=$1; fi
    echo "$N directories(total) in $path";
}


# --------------------------------------
#  create files/directories
# --------------------------------------
mkcd () { mkdir -p $1; cd $1; }

## create files with given authentications
t()
{
    if [ $# == 0 ]; then
        echo "[-] No arguments are given";
        return 1;
    fi

    argc=0
    argv=()

    while (( $# > 0 ))
    do
        case "$1" in
            -*)
                if [[ "$1" =~ 'm' ]]; then
                    M_VALUE="$2"
                    shift
                fi
                if [[ "$1" =~ 'h' ]]; then
                    echo "Usage: $0 [-m mode] filename1 (filename2 ...)"
                    echo "if mode are not given, mode becomes 711"1>&2
                    return 1;
                fi
                shift ;;
            *)
                ((++argc))
                argv=("${argv[@]}" "$1")
                shift ;;
        esac
    done

    if [ -z "$M_VALUE" ]; then
        M_VALUE=711
    fi

    touch ${argv[@]}
    chmod $M_VALUE ${argv[@]}
}

## free memory cache for pagecache->1, dentries and inodes->2, both 1 & 2->3
freecache()
{
    if [ $USER == "root" ]; then
        if [ -z "$1" ]; then N=1; else N=$1; fi
        echo "echo $N > /proc/sys/vm/drop_caches"
    else
        echo "[-] Need to be root (use 'sudo -i')"
    fi
}

cntcmd()
{
    if [ -z "$1" ]; then N=20; else N=$1; fi
    history | awk '{print $4}' | awk 'BEGIN{FS="|"}{print $1}' | sort | uniq -c | sort -nr | head -n $N
}
