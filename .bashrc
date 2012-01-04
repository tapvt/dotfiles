source ~/git-completion.bash
source ~/git-flow-completion.bash
alias bashrc='vi ~/.bashrc; source ~/.bashrc'
alias bash_profile='vi ~/.bash_profile; source ~/.bashrc'
alias gitconfig='vi ~/.gitconfig;'
alias kdir='cd /Users/bweller/repos/kohort'
#alias kwork='open /Users/bweller/Clients\ Projects/kohort/kohort.tmproj &'
alias plint='find . -name "*.php" -exec php -l {} \;'
alias src='source ~/.bash_profile'
alias ssh_gearman_dev='ssh gearman@ec2-50-19-74-255.compute-1.amazonaws.com'
alias e='vi'
alias cls='clear'
alias ll='ls -la'
alias lt='ls -lat'
# function ps@(){
#     ps aux | grep $1;
# }
# function ps@n(){
#     ps aux | grep -v $1;
# }
function showa(){
    /usr/bin/grep -i -a1 $@ ~/.bashrc ~/.bash_profile | grep -v '^\s*$';
}
function gssb(){
    git checkout $1  && git pull && git push -q && git merge develop && git checkout develop && git merge $1 && git pull && git push -q;
}
function gitmod(){
    git show --pretty="format:" --name-only {$1-$last};
}
function gitbranchdiff(){
    git diff --src-prefix=$1/ --dst-prefix=$2/ $1 $2
}
function gitpullall(){
    set -x
    git fetch --all
    for branch in "$@"; do
        git checkout "$branch"      || exit 1
        git rebase "origin/$branch" || exit 1
    done
}
function ktask()
{
    /Users/bweller/jira-cli-2.1.0/jira.sh --server=http://teamkohort.jira.com --user=ben --password=d543bw --action=getIssue --issue=$1;
    /Users/bweller/jira-cli-2.1.0/jira.sh --server=http://teamkohort.jira.com --user=ben --password=d543bw --action=getComments --issue=$1;
}
function kprogstart()
{
    /Users/bweller/jira-cli-2.1.0/jira.sh --server=http://teamkohort.jira.com --user=ben --password=d543bw --action=progressIssue --issue=$1 --step="Start Progress";
}
function kprogstop()
{
    /Users/bweller/jira-cli-2.1.0/jira.sh --server=http://teamkohort.jira.com --user=ben --password=d543bw --action=progressIssue --issue=$1 --step="Stop Progress";
}
function kresolve()
{
    /Users/bweller/jira-cli-2.1.0/jira.sh --server=http://teamkohort.jira.com --user=ben --password=d543bw --action=progressIssue --issue=$1 --step=5 --resolution="Fixed";
}
alias kcss='touch ~/repos/kohort/webroot/media/css/sass/*.scss && cd ~/repos/kohort/ && compass compile'
alias ksqlpreflight='mysql -h kohort-db01.ciu4vmglihsl.us-east-1.rds.amazonaws.com -u master -pLJxNIPwGlpnog preflight-doubleagency-com'
alias plint='find . -name "*.php" -exec php -l {} \; | grep "Parse error"'
alias ktasks="clear && /Users/bweller/jira-cli-2.1.0/jira.sh --action=getIssueList --server=http://teamkohort.jira.com --user=ben --password=d543bw --search='project = KO AND assignee = currentUser() AND fixVersion in (10010, 10017) AND status in (Open, \"In Progress\", Reopened, Resolved) ORDER BY status ASC, fixVersion ASC, priority DESC, cf[10012] ASC' | csvtool -t ',' col 1,16,5-8,12 - | csvtool readable -"

alias kcurrent="clear && /Users/bweller/jira-cli-2.1.0/jira.sh --action=getIssueList --server=http://teamkohort.jira.com --user=ben --password=d543bw --search='project = KO AND fixVersion = 10010 ORDER BY status ASC, priority DESC, updated ASC' | csvtool -t ',' col 1,16,5-8,12 - | csvtool readable - "
alias klog="tail -n 30 -f ~/repos/kohort/application/logs/$(date +%Y)/$(date +%m)/$(date +%d).php |perl -e "\''while(<>){s/^((\S+\s+){3}ERROR.*)$/\033[31m$1\033[0m /;print;}'\';
