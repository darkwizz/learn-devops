#!/usr/bin/env bash


############################################## Docker
#####################################################
if ! dpkg -s docker-ce > /dev/null; then
    # install a few prerequisite packages which let apt use packages over HTTPS
    sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

    # add the GPG key for the official Docker repository to your system
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    # add the Docker repository to APT sources
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

    sudo apt update
    sudo apt install -y docker-ce
fi

if ! dpkg -s docker-compose > /dev/null; then
    sudo apt install -y docker-compose
fi

if ! sudo systemctl is-active --quiet docker; then
    echo @@@@@@@@@@@@@@@ Starting Docker instance... @@@@@@@@@@@@@@@
    sudo systemctl start docker
else
    sudo systemctl status docker
fi

# as one of the ways to check if a user is in the docker group ->
# groups $USER | grep docker  => can be used in <if>
# if not to do this we won't be able to run docker commands without sudo
if ! groups $USER | grep docker; then
    sudo usermod -aG docker $USER
    exit
fi