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

# Install dependencies
sudo apt install bc imagemagick libjpeg-turbo8-dev libpam0g-dev libxcb-composite0 libxcb-composite0-dev \
    libxcb-image0-dev libxcb-randr0 libxcb-util-dev libxcb-xinerama0 libxcb-xinerama0-dev libxcb-xkb-dev \
    libxkbcommon-x11-dev feh libev-dev;

printf "\n";

sudo apt install checkinstall curl build-essential git;

printf "\n";

git clone https://github.com/PandorasFox/i3lock-color && cd i3lock-color;
autoreconf -i && ./configure;
make && sudo checkinstall --pkgname=i3lock-color --pkgversion=1;

cd .. && sudo rm -r i3lock-color;

printf -- "\n--------------------------------------------------------------------------------------------------------------";
printf "\n Dependencies installed! Proceeding ahead with the script.\n";
printf -- "--------------------------------------------------------------------------------------------------------------\n";

# Fetch the script
if [[ -f /usr/bin/betterlockscreen ]]; then
    sudo rm /usr/bin/betterlockscreen;
fi
curl -o script https://raw.githubusercontent.com/pavanjadhaw/betterlockscreen/master/betterlockscreen;
sudo cp script /usr/bin/betterlockscreen;
rm script;

printf -- "\n--------------------------------------------------------------------------------------------------------------";
printf "\n Installation complete!";
printf -- "\n--------------------------------------------------------------------------------------------------------------";
