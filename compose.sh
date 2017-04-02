#!/bin/bash
# This is comment line
#!/bin/bash
# This is comment line
PWD=$(pwd)
BASENAME_LOWER=$(basename $PWD | tr '[:upper:]' '[:lower:]')

install() {
    create_network;
    # build;
    up;
}

create_network(){
    # -z is if output is empty
    if [ -z "$(docker network ls | grep test)" ]; then
        docker network create test
    fi
}

# build() {
#     docker-compose build;
# }

up() {
    # pushd ./mariadb
    # docker-compose up -d;
    # popd
    
    pushd ./api
    docker-compose up -d;
    popd
    
    pushd ./site
    docker-compose up -d;
    popd
    
    pushd ./proxy
    docker-compose up -d;
    popd
}

down(){
    docker stop $(docker ps -a -q)
    docker rm $(docker ps -a -q)
}

destroy() {
    down;
    docker network rm test;
}

while getopts ":t:" opt; do
    case $opt in
        t) 
            # $OPTARG
            if [ -n "$(type -t $OPTARG)" ] && [ "$(type -t $OPTARG)" = function ]
                then $OPTARG;
                else echo $OPTARG is NOT a function; 
            fi
        ;;
    esac
done

# shift the arguments
shift $(($OPTIND - 1))