#! /bin/bash
FOLDER=$(echo "${PWD}")
ZABUD_HOME=$HOME/Zabud

branch="develop"
set -e

if [ $# -eq 1 ] && [ "$1" != "-y" ]; then
    echo "The parameter $1 not recognize"
    exit 1
fi

for repo in $(ls $ZABUD_HOME)
do
    if [ -d $ZABUD_HOME/$repo ] && [ -d $ZABUD_HOME/$repo/.git ]; then
	cd $ZABUD_HOME/$repo
        if [ "$repo" == "akatsuki-repo" ]; then
            if [ $# -eq 1 ] && [ "$1" == "-y" ]; then
                for branch in $(echo "dev qa local")
                do
    		    if [ ! -f $branch ]; then
                        git checkout $branch
                        git pull origin $branch
                    fi
                done
            fi
        else
            branch=$(git branch --show-current)
            git pull origin $branch
        fi

    else
        cowsay -f tux "$repo not is a repository"
    fi
done
cd $FOLDER
