#/bin/bash

#-------------------------------------------------------------------------------------
# MIT License
# Copyright (c) 2018 Utkarsh Verma <utkarshverma@pm.me>
# Permission is hereby granted, free of charge, to any person obtaining a copy 
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#-------------------------------------------------------------------------------------

# Bash installation script for installing 'https://github.com/pavanjadhaw/betterlockscreen' in one go.
# Run this script as root

# Installation candidate name
install_candidate="betterlockscreen";

# Install dependencies
printf -- "----------------------------------------------------------------------------------------------------";
printf "\n Installing dependencies. May take a few minutes.\n";
printf -- "----------------------------------------------------------------------------------------------------\n";

## Check for and install absent auxiliary packages
AUX_PACK="build-essential checkinstall curl git";
ABSENT_PACKAGES="";
for package in $AUX_PACK; do
	packageExists="";
	[[ $(echo `dpkg-query -W $package 2>&1` | grep -o "no packages found") = "" ]] && packageExists="exists";
	[[ ! $packageExists ]] && ABSENT_PACKAGES+="$package ";
done
[[ $ABSENT_PACKAGES ]] && sudo apt install $AUX_PACK;
printf "\n";

## Dependencies
sudo apt install bc imagemagick libjpeg-turbo8-dev libpam0g-dev libxcb-composite0 libxcb-composite0-dev \
    libxcb-image0-dev libxcb-randr0 libxcb-util-dev libxcb-xinerama0 libxcb-xinerama0-dev libxcb-xkb-dev \
    libxkbcommon-x11-dev feh libev-dev;
printf "\n";

## Install i3lock-color dependency
git clone https://github.com/PandorasFox/i3lock-color && cd i3lock-color;
autoreconf -i; ./configure;
make; sudo checkinstall --pkgname=i3lock-color --pkgversion=1 -y;
cd .. && sudo rm -r i3lock-color;

printf -- "\n----------------------------------------------------------------------------------------------------";
printf "\n Dependencies installed! Proceeding ahead with the script.\n";
printf -- "----------------------------------------------------------------------------------------------------\n";

# Fetch the script and remove it after copying
if [[ -f /usr/bin/betterlockscreen ]]; then
    sudo rm /usr/bin/betterlockscreen;
fi
curl -o script https://raw.githubusercontent.com/pavanjadhaw/betterlockscreen/master/betterlockscreen;
sudo cp script /usr/bin/betterlockscreen;
rm script;

printf -- "\n----------------------------------------------------------------------------------------------------";
printf "\n Script installed! Removing unused packages.\n";
printf -- "----------------------------------------------------------------------------------------------------\n";

## Remove non-pre-existing auxiliary packages
[[ $ABSENT_PACKAGES ]] && sudo apt remove $ABSENT_PACKAGES;

# Add logs for the installation candidate
sudo echo "$install_candidate - Installed on $(date)" >> /etc/installer-scripts.log;

printf -- "\n----------------------------------------------------------------------------------------------------";
printf "\n Installation complete! Feel free to use the '$install_candidate' command now.";
printf -- "\n----------------------------------------------------------------------------------------------------";