#! /bin/bash
FOLDER=$(echo "${PWD}")

set -e

if [ $# -eq 1 ] && [ "$1" != "-y" ]; then
    echo "The parameter $1 not recognize"
    exit 1
fi

if [ -z $ZABUD_HOME ]; then
    echo "The enviroment variable ZABUD_HOME is required"
    exit 1
fi

for repo in $(ls $ZABUD_HOME)
do
    if [ -d $ZABUD_HOME/$repo ] && [ -d $ZABUD_HOME/$repo/.git ]; then
	cd $ZABUD_HOME/$repo
        if [ "$repo" == "zabud-config-server-repo" ]; then
            if [ $# -eq 1 ] && [ "$1" == "-y" ]; then
                for branch in $(echo "dev qa colombo unicolombo")
                do
    		    if [ ! -f $branch ]; then
                        git checkout $branch
                        git pull origin $branch
                    fi
                done
            fi
        else
            branch=$(git branch --show-current)
            #branch="develop"
            #git checkout develop
            git pull origin $branch
        fi

    else
        cowsay "$repo not is a repository"
    fi
done
cd $FOLDER
