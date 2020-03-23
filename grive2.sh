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

# Bash installation script for installing 'https://github.com/vitalif/grive2' in one go.
# Run this script as root

# Installation candidate details
install_candidate="grive2";
command="grive"
vendor="GitHub/vitalif";
repo="https://github.com/vitalif/grive2"

AUX_PACK="build-essential checkinstall cmake git pkg-config";
DEP="libgcrypt20-dev libyajl-dev libboost-all-dev libcurl4-openssl-dev \
    libexpat1-dev libcppunit-dev binutils-dev zlib1g-dev";

printf -- "----------------------------------------------------------------------------------------------------";
printf "\n Installing dependencies. May take a few minutes.\n";
printf -- "----------------------------------------------------------------------------------------------------";

# Check for and install absent auxiliary packages
ABSENT_PACKAGES="";
for package in $AUX_PACK; do
	packageExists="";
	[[ $(echo `dpkg-query -W $package 2>&1` | grep -o "no packages found") = "" ]] && packageExists="exists";
	[[ ! $packageExists ]] && ABSENT_PACKAGES+="$package ";
done
[[ $ABSENT_PACKAGES ]] && sudo apt install $AUX_PACK;
printf "\n";

# Fetch version of script
version=$(git ls-remote -q --tags $repo | tail -1 | grep -oP "(?<=v).*$");

# Install dependencies
sudo apt install $DEP;

printf -- "\n----------------------------------------------------------------------------------------------------";
printf "\n Dependencies installed! Proceeding ahead with the installation.\n";
printf -- "----------------------------------------------------------------------------------------------------\n";

# Fetch the source code
git clone $repo;

# Build the source code and install it
cd $install_candidate;
mkdir build && cd build;
cmake ..;
make -j4;
sudo checkinstall --pkgname $install_candidate --pkgversion $version -y;

printf -- "\n----------------------------------------------------------------------------------------------------";
printf "\n '$install_candidate' installed! Removing unused packages.\n";
printf "\n If you wish to uninstall it, use 'sudo dpkg -r $install_candidate'."
printf -- "\n----------------------------------------------------------------------------------------------------\n";

# Remove non-pre-existing auxiliary packages
[[ $ABSENT_PACKAGES ]] && sudo apt remove $ABSENT_PACKAGES;

# Add logs for the installation candidate
echo "$install_candidate - $vendor; $version; $(date); $(date +%s)" | \
	sudo tee --append /etc/installer-scripts.log > /dev/null;

printf -- "\n----------------------------------------------------------------------------------------------------";
printf "\n Installation complete! Feel free to use the '$command' command now.";
printf -- "\n----------------------------------------------------------------------------------------------------";
