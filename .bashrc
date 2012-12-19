export EDITOR=`which vim`
source ~/git-completion.bash
source ~/src/bashmarks/bashmarks.sh
alias v='vi -p '
alias tl='tmux list-sessions'
alias ta='tmux attach-session'
alias tat='tmux attach-session -t'
alias bashrc='vi ~/.bashrc; source ~/.bashrc'
alias bash_profile='vi ~/.bash_profile; source ~/.bashrc'
alias gitconfig='vi ~/.gitconfig;'
alias plint='find . -name "*.php" -exec php -l {} \;'
alias src='source ~/.bash_profile'
alias cls='clear'
alias ll='ls -la'
alias lt='ls -lat'
alias chef-roles='for file in `find ~/repos/kohort_chef/roles/ -path "*\.json"`; do knife role from file $file; done'
alias chef-sync='knife cookbook upload -a; chef-roles;'
alias plint='find . -name "*.php" -exec php -l {} \; | grep "Parse error"'

if [ -f /opt/local/etc/bash_completion ]; then
. /opt/local/etc/bash_completion
fi

function cgo(){                               
  (echo "%s/${2}/${3}/g"; echo 'wq') | ex -s ${1} 
}


[ -s "/Users/bweller/.scm_breeze/scm_breeze.sh" ] && source "/Users/bweller/.scm_breeze/scm_breeze.sh"


function kssh () {
        host=`knife node show "$1" -a ec2.public_hostname -F pp`;
        ssh -i ~/.ssh/kohort_primary.pem ubuntu@$host;
}

kssh_opts=$(knife node list | perl -ne 'chomp and print');

_kssh() {
    local cur
    cur="${COMP_WORDS[COMP_CWORD]}"
    COMPREPLY=($(compgen -W "${kssh_opts}" -- ${cur}))
}


alias gpc='git push origin `gcb`'
export PATH=$HOME/bin:$PATH
