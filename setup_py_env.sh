#!/usr/bin/env bash

if ! dpkg -s python-pip > /dev/null; then
    sudo apt install -y python-pip
fi

if ! dpkg -s python3-pip > /dev/null; then
    sudo apt install -y python3-pip
fi

sudo apt install -y tree

# WARNING: for Vagrant boxes can't use links on python
# should copy the binaries instead:
# virtualenv --always-copy <name>
# see: https://github.com/gratipay/gratipay.com/issues/2327
pip3 install virtualenv

pip3 install ansible --upgrade
# AWS access
pip3 install boto boto3
pip3 install awscli