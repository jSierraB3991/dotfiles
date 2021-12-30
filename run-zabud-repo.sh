#! /bin/bash

ZABUD_HOME=$HOME/Zabud
FOLDER=${PWD}

if [ $# -eq 1 ] || [ $# -eq 2 ]; then

    if [ -d $ZABUD_HOME/$1 ] && [ -d $ZABUD_HOME/$1/.git ] && [ -f $ZABUD_HOME/$1/pom.xml ]; then
        
        if [ $# -eq 2 ]  || [ -f $ZABUD_HOME/$1/target/$1.jar ]; then
            cd $ZABUD_HOME/$1
            if [ $# -eq 2 ]; then
                echo "Clean Projects $1"
                $(mvn clean)
                echo "Installing dependencies"
                $(mvn install)
                echo "Copi final file in $1.jar"
                cd target
                cp "$1-0.0.1-SNAPSHOT.jar" $1.jar
                cd -
            fi
            screen java -jar target/$1.jar
	    cd $FOLDER
        else
            echo "The file $1.jar not exists"
        fi

    else
        echo "The one parameter, is not valid"
    fi
else
    cowsay "I need parameter"
fi

