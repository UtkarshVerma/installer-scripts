#/bin/bash
# Bash installation script for installing 'https://github.com/pavanjadhaw/betterlockscreen' in one go.
# Run this script as root

# Installation candidate details
install_candidate="betterlockscreen";
vendor="GitHub/pavanjadhaw";
repo="https://github.com/pavanjadhaw/betterlockscreen"

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

# Fetch version of script
version=$(git ls-remote -q --tags $repo | tail -1 | grep -oP "(?<=v).*$");

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
sudo chmod +x /usr/bin/betterlockscreen;
rm script;

printf -- "\n----------------------------------------------------------------------------------------------------";
printf "\n Script installed! Removing unused packages.\n";
printf -- "----------------------------------------------------------------------------------------------------\n";

## Remove non-pre-existing auxiliary packages
[[ $ABSENT_PACKAGES ]] && sudo apt remove $ABSENT_PACKAGES;

# Add logs for the installation candidate
echo "$install_candidate - $vendor; $version; $(date); $(date +%s)" | sudo tee --append /etc/installer-scripts.log > /dev/null;

printf -- "\n----------------------------------------------------------------------------------------------------";
printf "\n Installation complete! Feel free to use the '$install_candidate' command now.";
printf -- "\n----------------------------------------------------------------------------------------------------";
