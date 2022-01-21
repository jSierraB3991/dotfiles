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

alias run-zabud-core="nohup $DOTFILES/run-spring-proyect.sh zabud-tronos-core-ms $1 &"
alias run-zabud-inscription="nohup $DOTFILES/run-spring-proyect.sh zabud-inscriptions-ms $1 &"
