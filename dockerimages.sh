GITHUB_HOME=$HOME/github
ZABUD_HOME=$HOME/Zabud

if [ -d $GITHUB_HOME ]; the
    mkdir $GITHUB_HOME
fi

sudo docker run --rm -d -p 27017:27017 --name mongo-inscription mongo:5.0.3-focal
sudo docker run --rm -d -p 5432:5432 --name pg-inscription -v $ZABUD_HOME/data/pg-inscription:/var/lib/postgresql/data -e POSTGRES_USER=postgre -e POSTGRES_DB=zabud-inscription -e POSTGRES_PASSWORD=root postgres:12.9-alpine
sudo docker run --rm -d -p 5433:5432 --name pg-core -v $ZABUD_HOME/data/pg-core:/var/lib/postgresql/data -e POSTGRES_USER=postgre -e POSTGRES_DB=zabud-core -e POSTGRES_PASSWORD=root postgres:12.9-alpine
sudo docker run --rm -d -p 5434:5432 --name pg-notification -v $ZABUD_HOME/data/pg-notification:/var/lib/postgresql/data -e POSTGRES_USER=postgre -e POSTGRES_DB=zabud-notification -e POSTGRES_PASSWORD=root postgres:12.9-alpine

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
#sudo sudo docker build -t zabud-discovery:1.0 .
sudo docker run --rm -d -p 8761:8761 --name zabud-discovery zabud-discovery:1.0
cd -


