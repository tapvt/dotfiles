RED="\[\e[0;31m\]"
YELLOW="\[\e[0;33m\]"
GREEN="\[\e[0;32m\]"
WHITE="\[\e[0;37m\]"
function ref(){
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\[\1\]/' || return
}
function sha(){
    git rev-parse --short HEAD 2> /dev/null | sed -e 's/\(.*\)/\[\1\]/' || return
}
PS1="$GREEN\u@\h$YELLOW\$(ref)\$(sha)\[\e[0m\][\w]\$ "

export PATH=/user/local/share/pear/:/opt/local/bin:/opt/local/sbin:$PATH
export HISTCONTROL=erasedups
export HISTSIZE=30000
export KPATH=/Users/bweller/repos/kohort
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/
ulimit -u 256
shopt -s histappend
source ~/.bashrc;
