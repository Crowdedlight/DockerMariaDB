FROM ubuntu:latest

MAINTAINER Frederik Mazur crowdedhd@gmail.com

RUN apt-get update && apt-get install -y software-properties-common && \
    apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8 && \
    add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://mirrors.dotsrc.org/mariadb/repo/10.1/ubuntu xenial main' && \
    apt update

RUN bash -c 'debconf-set-selections <<< "mariadb-server mysql-server/root_password password mariadb"'
RUN bash -c 'debconf-set-selections <<< "mariadb-server mysql-server/root_password_again password mariadb"'

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mariadb-server

RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

VOLUME ["/data/mysql", "/var/lib/mysql"]
WORKDIR /data

ADD ./startup.sh /opt/startup.sh
RUN /opt/startup.sh

EXPOSE 3306

CMD ["/usr/bin/mysqld_safe"]


