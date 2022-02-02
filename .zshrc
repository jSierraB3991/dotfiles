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
alias podman="sudo docker"
alias podman-stop-all-containers="sudo docker stop \$(sudo docker ps -q)"
alias podman-remove-all-containers="sudo docker rm \$(sudo docker ps -aq)"
alias podman-stop-and-remove-all-containers="podman-stop-all-containers && podman-remove-all-containers"
alias podman-compose="sudo docker-compose"
alias run-pg-platzi="podman run --rm -d --name pg-platzi -e POSTGRES_USER=postgres -e POSTGRES_DB=platzi -e POSTGRES_PASSWORD=root postgres:12.9-alpine"
alias run-maria-platzi="podman run --rm -d --name mariadb-platzi -e MARIADB_USER=mariadb -e MARIADB_ROOT_PASSWORD=chroot -e MARIADB_PASSWORD=root mariadb:10.6.5-focal"

alias show-podman-containers="podman ps -a --format \"table {{.State}}\\t{{.Names}}\\t{{.ID}}\\t{{.Image}}\""

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

if [ "$(whoami)" != "root" ]; then
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
fi
#
