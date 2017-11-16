#!/bin/bash -xe

function prepare {
    cp /root/kestonercv3 /home
    cp install_tempest.sh /home
    cp config_file /home
}

function install_docker_and_run {
    apt-get install -y docker.io
    docker pull rallyforge/rally:0.9.0
    image_id=$(docker images | grep 0.1.0| awk '{print $3}')
    docker run --net host -v /home/:/home/rally -v /etc/ssl/certs/:/etc/ssl/certs/ -tid -u root $image_id
    docker_id=$(docker ps | grep $image_id | awk '{print $1}'| head -1)
}

function configure_tempest {
    docker exec -ti $docker_id bash -c "./install_tempest.sh"
    docker exec -ti $docker_id bash -c "apt-get install -y vim"
    docker exec -ti $docker_id bash
}

prepare
install_docker_and_run
configure_tempest
