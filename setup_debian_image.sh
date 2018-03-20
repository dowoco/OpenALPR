#!/bin/bash

#set -e

# For Raspbian Stretch (late 2017 onwards) enable the Debian Backports repsitory
apt update
apt install -y dirmngr
apt-key adv --keyserver keyserver.ubuntu.com --recv-key 8B48AD6246925553
apt-key adv --keyserver keyserver.ubuntu.com --recv-key 7638D0442B90D010
echo "deb http://ftp.debian.org/debian stretch-backports main contrib non-free" | tee /etc/apt/sources.list.d/backports.list
chmod 644 /etc/apt/sources.list.d/backports.list
apt install -y cifs-utils

# Update and Upgrade, otherwise the build may fail due to inconsistencies
apt update && apt upgrade -y
