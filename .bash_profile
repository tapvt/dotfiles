RED="\[\e[0;31m\]"
YELLOW="\[\e[0;33m\]"
GREEN="\[\e[0;32m\]"
WHITE="\[\e[0;37m\]"
_PS1(){
    local PRE= NAME="$1" LENGTH="$2";
    [[ "$NAME" != "${NAME#$HOME/}" || -z "${NAME#$HOME}" ]] &&
        PRE+='~' NAME="${NAME#$HOME}" LENGTH=$[LENGTH-1];
    ((${#NAME}>$LENGTH)) && NAME="/...${NAME:$[${#NAME}-LENGTH+4]}";
    echo "$PRE$NAME"
}
function ref(){
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\[\1\]/' || return
}
function sha(){
    git rev-parse --short HEAD 2> /dev/null | sed -e 's/\(.*\)/\[\1\]/' || return
}
PS1="\[\033[G\]$GREEN\$(_PS1 \w 20)$YELLOW\$(ref)\$(sha)$RED[\j]$WHITE\$ "

export EC2_HOME=~/.ec2
export PATH=$PATH:$EC2_HOME/bin
export EC2_PRIVATE_KEY=$EC2_HOME/rwpk.pem
export EC2_CERT=$EC2_HOME/rwcert.pem
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/

export PATH=/user/local/share/pear/:/opt/local/bin:/opt/local/sbin:$PATH
export HISTSIZE=300000
export KPATH=/Users/bweller/repos/kohort
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/
ulimit -u 256
shopt -s histappend
alias gcb="git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/' || return"
alias gpc="git push origin `gcb`"
source ~/.bashrc;
[[ -s /Users/bweller/.nvm/nvm.sh ]] && . /Users/bweller/.nvm/nvm.sh # This loads NVM
