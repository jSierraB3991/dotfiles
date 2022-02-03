#! /bin/bash

if [ ! -d $GITHUB_HOME ]; then
    mkdir $GITHUB_HOME
fi

sudo docker run --rm -d -p 27017:27017 --name mongo-inscription mongo:5.0.3-focal

function run-postgre-database(){
    port=$1
    name=$2
    sudo docker run --rm -d -p $port:5432 \
                            --name $name \
                            -v $ZABUD_HOME/data/$name:/var/lib/postgresql/data \
                            -e POSTGRES_USER=postgre -e POSTGRES_DB=$name -e POSTGRES_PASSWORD=root \
                            postgres:12.9-alpine
}
run-postgre-database 5432 zabud-inscription
run-postgre-database 5433 zabud-core
run-postgre-database 5434 zabud-notification

if [ ! -d $GITHUB_HOME/JSierraB3991/Docker ]; then
    if [ ! -d $GITHUB_HOME/JSierraB3991 ]; then
        mkdir $GITHUB_HOME/JSierraB3991
    fi
    cd $GITHUB_HOME/JSierraB3991
    git clone https://github.com/jSierraB3991/Docker.git
    cd -   
fi

sudo docker run --rm --name activemq -d -p 8161:8161 -p 61616:61616 rmohr/activemq:5.14.0-alpine
cd $GITHUB_HOME/JSierraB3991/Docker
sudo docker-compose -f kafka-compose.yml up -d
cd -

cd $ZABUD_HOME/zabud-discovery-ms
if [ ! -f $ZABUD_HOME/zabud-discovery-ms/Dockerfile ]; then
    cp $GITHUB_HOME/JSierraB3991/Docker/spring-Dockerfile ./Dockerfile
fi
cd -

application="zabud-discovery"
version="1.0"
dockerimage=$(sudo docker images --format "{{.Repository}}" $application:$version)
if [ "$dockerimage" == "" ]; then
    read -p "you image $application:$version not exists, Dou you like build image?: " response

    if [ $response == "y" ] || [ $response == "s" ] || [ $response == "Y" ] || [ $response == "S" ]; then
        cd $ZABUD_HOME/zabud-discovery-ms
        sudo sudo docker build -t zabud-discovery:1.0 .
    fi
fi
dockerimage=$(sudo docker images --format "{{.Repository}}" $application:$version)
if [ "$dockerimage" != "" ]; then
    sudo docker run --rm -d -p 8761:8761 --name $application $application:$version
fi

cd -
