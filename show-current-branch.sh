#! /bin/bash

ZABUD_HOME=$HOME/Zabud
CURRENT_DIR=${PWD}

if [ -d $ZABUD_HOME ]; then

    for repository in $(ls $ZABUD_HOME); do
        if [ -d $ZABUD_HOME/$repository ] && [ -d $ZABUD_HOME/$repository/.git ]
        then
            cd $ZABUD_HOME/$repository
            echo "The actually branch in the repository: $repository" \
                 " is: $(git branch --show-current)"
        fi
    done

else
    cowsay "directory $ZABUD_HOME no found"
fi

cd $CURRENT_DIR

