# DockerMariaDB

## RUN

docker run --name mariadb -d -p 3306:3306 -v /data/mysql:/var/lib/mysql crowdedlight/mariadb


## ACCESS RUNNING CONTAINER
docker exec -it "mariadb" bash

## BUILD

docker build -t crowdedlight/mariadb .


psw for root/admin mysql: mariadb
psw for phpuser mysql: password
