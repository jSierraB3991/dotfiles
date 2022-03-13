alias neofetch="/usr/bin/neofetch --ascii ~/.config/neofetch/ascii.txt"
alias podman-stop-all-containers="sudo docker stop \$(sudo docker ps -q)"
alias podman-remove-all-containers="sudo docker rm \$(sudo docker ps -aq)"
alias podman-stop-and-remove-all-containers="podman-stop-all-containers && podman-remove-all-containers"
alias podman-compose="sudo docker-compose"
alias run-maria-platzi="sudo docker run --rm -d -network host --name mariadb-platzi -e MARIADB_USER=mariadb -e MARIADB_ROOT_PASSWORD=chroot -e MARIADB_PASSWORD=root mariadb:10.6.5-focal"

alias podman-containers="sudo docker ps -a --format \"table {{.State}}\\t{{.Names}}\\t{{.ID}}\\t{{.Image}}\""

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ $KEYMAP == vicmd ]] || [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ $KEYMAP == main ]] || [[ $KEYMAP == viins ]] || [[ $KEYMAP = '' ]] || [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}

zle -N zle-keymap-select
zle-line-init() { zle-keymap-select 'beam'}
