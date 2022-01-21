alias ll="lsd -l"
alias la="lsd -lA"
alias ll-tree="lsd -l --tree"
alias cat="bat --paging=never"
alias cpufetch="/opt/cpufetch/cpufetch"
alias public-ip="curl -s checkip.dyndns.org | grep -Eo '[0-9.]+'"
alias tree="lsd --tree"
alias catt="/usr/bin/cat"
alias git-tree="git log --all --graph --decorate --oneline"
alias neofetch="/usr/bin/neofetch --ascii ~/.config/neofetch/ascii.txt"



function run-zabud-core() {
    FOLDER=${PWD}
    cd ~/logs
    nohup $DOTFILES/run-spring-proyect.sh zabud-tronos-core-ms $1 &
    cd $FOLDER
}

function run-zabud-inscription() {
    FOLDER=${PWD}
    cd ~/logs
    nohup $DOTFILES/run-spring-proyect.sh zabud-inscriptions-ms $1 &
    cd $FOLDER
}

################################################################################
################################## GIT SSH #####################################

env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2=agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi

unset env
#


alias show-docker="sudo docker ps --format \"table {{.State}}\\t{{.Names}}\\t{{.ID}}\\t{{.Image}}\""
