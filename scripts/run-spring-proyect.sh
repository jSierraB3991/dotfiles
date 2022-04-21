#!/bin/bash

REPO_HOME=$ZABUD_HOME

if [ $# -eq 1 ] || [ $# -eq 2 ]; then
    echo "$REPO_HOME/$1"
    if [ -d $REPO_HOME/$1 ] && [ -d $REPO_HOME/$1/.git ]; then
        if [ $# -eq 2 ]; then
            if [ "$2" == "-y" ] || [ "$2" == "-Y" ] || 
                [ "$2" == "-s" ] || [ "$2" == "-S" |]; then
                if [ ! -d $HOME/logs ]; then
                    mkdir $HOME/logs
                fi
                echo "" > "$HOME/logs/$1.log"

                cd $REPO_HOME/$1
                echo "clean project && install dependencies, see file ~/logs/$1.log"
                if [ -d ~/target ]; then
        	    rm -rf ./target
                fi
                mvn -U -V -B -s settings.xml clean install -DskipTests=false -L "$HOME/logs/$1.log"

                echo "coping image"
                cp "target/$1-0.0.1-SNAPSHOT.jar" "target/$1.jar"
                cd -
            fi
        fi
        if [ -f "$REPO_HOME/$1/target/$1.jar" ]; then
            java -jar "$REPO_HOME/$1/target/$1.jar"
        else
            echo "Not exist file $1.jar"
        fi
    else
        cowsay "the folder $REPO_HOME/$1 not exists"
    fi
else
    cowsay "The script need almost one parameter"
fi
