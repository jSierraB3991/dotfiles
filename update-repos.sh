#! /bin/bash

FOLDER=$(echo "${PWD}")

branch="develop"
for repo in $(ls $ZABUD_HOME)
do
    if [ -d $ZABUD_HOME/$repo ] && [ -d $ZABUD_HOME/$repo/.git ]; then
	cd $ZABUD_HOME/$repo
        if [ "$repo" == "akatsuki-repo" ]; then
            for branch in $(git branch -l)
            do
		if [ ! -f $branch ]; then
                    git checkout $branch
                    git pull origin $branch
                fi
            done
            git checkout local
        else
            branch=$(git branch --show-current)
            git pull origin $branch
        fi

    else
        cowsay -f tux "$repo not is a repository"
    fi
done
cd $FOLDER
