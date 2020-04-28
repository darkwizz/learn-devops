#!/usr/bin/env bash

if ! dpkg -s default-jre > /dev/null; then
    # -y means "yes"
    sudo apt-get update
    sudo apt-get install -y default-jre
fi

############################################## Jenkins
######################################################
if ! dpkg -s jenkins > /dev/null; then
    # "-q" means "quiet", no output
    # "-O" means download to a file
    # "add -" means read the key from stdin
    echo @@@@@@@@@@@@@@@ Adding Jenkins keys... @@@@@@@@@@@@@@@
    wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add - &&\

    # When the key is added, the system will return OK. Next,
    # append the Debian package repository address to the server’s sources.list
    echo @@@@@@@@@@@@@@@ Appending Debian package repo... @@@@@@@@@@@@@@@ &&\
    sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list' &&\

    sudo apt update &&\
    sudo apt install -y jenkins
    export JENKINS_HOME=/var/lib/jenkins
    # admin pass: 140c405dc7bc4ad6a1bc2ffab539538c
fi
if ! sudo systemctl is-active --quiet jenkins; then
    echo @@@@@@@@@@@@@@@ Starting Jenkins instance... @@@@@@@@@@@@@@@
    sudo systemctl start jenkins
else
    sudo systemctl status jenkins
fi