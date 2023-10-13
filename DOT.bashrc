#BASHRC
#20230929_10:32_est--EJR
# Check if the shell is interactive; if not, return
  [ -z "$PS1" ] && return
# History settings to ignore duplicates and enable history append
  HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
  HISTCONTROL=ignoreboth
  shopt -s histappend
# Check and set window size after each command
  shopt -s checkwinsize
# Set 'debian_chroot' if it's not already set from /etc/debian_chroot
  if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
  fi
# Set 'color_prompt' if the terminal supports color
  case "$TERM" in
    xterm-color) color_prompt=yes;;
  esac
# Determine if a color prompt should be used based on 'force_color_prompt'
if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    color_prompt=yes
  else
    color_prompt=
  fi
fi
# Set the prompt based on whether color is enabled
  if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
  fi
# Unset temporary color variables
  unset color_prompt force_color_prompt
# color variables
  red='\[\e[0;31m\]'; RED='\[\e[1;31m\]'; blue='\[\e[0;34m\]'; BLUE='\[\e[1;34m\]'; cyan='\[\e[0;36m\]'; CYAN='\[\e[1;36m\]';
  green='\[\e[0;32m\]'; GREEN='\[\e[1;32m\]'; yellow='\[\e[0;33m\]'; YELLOW='\[\e[1;33m\]'; PURPLE='\[\e[1;35m\]';
  purple='\[\e[0;35m\]'; nc='\[\e[0m\]'
# Set the root and user prompts with colors
  if [ "$UID" = 0 ]; then
    PS1="$red\u$nc@$red\H$nc:$CYAN\w$nc\\n$red#$nc "
  else
    PS1="$PURPLE\u$nc@$CYAN\H$nc:$GREEN\w$nc\\n$GREEN\$$nc "
  fi
# Configure colors for 'ls', 'dir', 'vdir', 'grep', 'fgrep', and 'egrep'
  if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
  fi
# Aliases for 'ls'
  alias ll='ls -lh'
  alias la='ls -A'
  alias l='ls -CF'
# Set LESS (Defaults) / -R: show ANSI colors correctly / -i: case insensitive search
  LESS="-R -i"
# Source bash completion if available
  if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
  fi
# Ensure that '/sbin' and '/usr/sbin' are in the PATH
  echo $PATH | grep -Eq "(^|:)/sbin(:|)"     || PATH=$PATH:/sbin
  echo $PATH | grep -Eq "(^|:)/usr/sbin(:|)" || PATH=$PATH:/usr/sbin
# Customize the terminal prompt for specific terminal types
  case "$TERM" in
    xterm*|rxvt*) PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1";;
    *);;
  esac
#= EJR ====================================================
# Enable dotglob for hidden files in pathname expansion
  shopt -s dotglob
# Shared aliases and custom path additions
  [ -e "$HOME/.alias" ] && . ~/.alias
  [ -e "$HOME/a-me/bin" ] && PATH="$HOME/a-me/bin:$PATH"
  [ -e "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
