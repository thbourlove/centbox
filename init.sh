#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

function UpdateYumRepo() {
    if ! cmp -s /tmp/configurations/fastestmirror.conf /etc/yum/pluginconf.d/fastestmirror.conf; then
        cp /tmp/configurations/fastestmirror.conf /etc/yum/pluginconf.d/fastestmirror.conf
    fi

    if ! cmp -s /tmp/configurations/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo; then
        cp /tmp/configurations/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo
        yum clean all
        yum update -y
    fi
}

function InstallTools() {
    yum install git vim wget net-tools tcpdump -y
}

function FishConfiguration() {
    if [ ! -d /home/vagrant/.config/fish ]; then
        wget https://raw.github.com/thbourlove/fish/master/install.sh -O - | su -c sh vagrant
    fi

    if ! cmp -s /tmp/configurations/fish.repo /etc/yum.repos.d/fish.repo; then
        cp /tmp/configurations/fish.repo /etc/yum.repos.d/fish.repo
        yum install fish -y
        chsh -s /usr/bin/fish vagrant
    fi
}

function GitConfigurations() {
    if [ ! -e /home/vagrant/.gitconfig ]; then
        su -c 'cp /tmp/configurations/.gitconfig ~/.gitconfig' vagrant
    fi
}

function VimConfigurations() {
    if [ ! -d /home/vagrant/.vim ]; then
        wget https://raw.github.com/thbourlove/vim/master/install.sh -O - | su -c sh vagrant
    fi
}

function TmuxConfigurations() {
    if [ ! -d /home/vagrant/.tmux ]; then
        wget https://raw.github.com/thbourlove/tmux/master/install -O - | su -c sh vagrant
    fi
}

function CleanConfigurations() {
    rm -rf /tmp/configurations
}

UpdateYumRepo
InstallTools
FishConfiguration
GitConfigurations
VimConfigurations
TmuxConfigurations
CleanConfigurations
