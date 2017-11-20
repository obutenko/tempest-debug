#!/bin/bash -xe

function prepare {
    mkdir /root/mount
    cp /root/keystonercv3 /root/mount
    cp install_tempest.sh /root/mount
    cp tempest_conf /root/mount
}

function install_docker_and_run {
    apt-get install -y docker.io
    docker pull rallyforge/rally:0.9.1
    image_id=$(docker images | grep 0.9.1| awk '{print $3}')
    docker run --net host -v /root/mount:/home/rally -v /etc/ssl/certs/:/etc/ssl/certs/ -tid -u root $image_id
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
