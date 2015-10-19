#!/bin/bash

if [[ -z $USER_NAME ]]; then
    echo USER_NAME must be specified
    exit 1;
fi

USER_HOME=/home/$USER_NAME

useradd -G docker $USER_NAME

USER_SSH_DIR=$USER_HOME/.ssh

if [[ -n $USER_PUBLIC_KEY ]]; then
    mkdir -p $USER_SSH_DIR
    chown $USER_NAME:$USER_NAME $USER_SSH_DIR
    echo $USER_PUBLIC_KEY > $USER_SSH_DIR/authorized_keys
    chown $USER_NAME:$USER_NAME $USER_SSH_DIR/authorized_keys
    chmod 600 $USER_SSH_DIR/authorized_keys
fi

USER_DOCKER_DIR=$USER_HOME/.docker
DOCKER_CONFIG="{\"auths\": $USER_DOCKERCFG}"

if [[ -n $USER_DOCKERCFG ]]; then
    mkdir -p $USER_DOCKER_DIR
    chown $USER_NAME:$USER_NAME $USER_DOCKER_DIR
    echo $DOCKER_CONFIG > $USER_DOCKER_DIR/config.json
    chown $USER_NAME:$USER_NAME $USER_DOCKER_DIR/config.json
    chmod 600 $USER_DOCKER_DIR/config.json
fi
