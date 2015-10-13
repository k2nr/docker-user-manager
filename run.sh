#!/bin/bash

USER_SSH_DIR=/home/$USER_NAME/.ssh

if [[ -z $USER_NAME ]]; then
    echo USER_NAME must be specified
    exit 1;
fi

useradd -G docker $USER_NAME

if [[ -n $USER_PUBLIC_KEY ]]; then
    mkdir -p $USER_SSH_DIR
    chown $USER_NAME:$USER_NAME $USER_SSH_DIR
    echo $USER_PUBLIC_KEY > $USER_SSH_DIR/authorized_keys
    chown $USER_NAME:$USER_NAME $USER_SSH_DIR/authorized_keys
    chmod 600 $USER_SSH_DIR/authorized_keys
fi
