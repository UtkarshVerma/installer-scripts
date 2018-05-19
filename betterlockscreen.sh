#/bin/bash
# Bash installation script for installing 'betterlockscreen' by 'pavanjadhav' in one go. GitHub: https://github.com/pavanjadhaw/betterlockscreen
# Run this script as root

# Install dependencies
sudo apt install bc imagemagick libjpeg-turbo8-dev libpam0g-dev libxcb-composite0 libxcb-composite0-dev \
    libxcb-image0-dev libxcb-randr0 libxcb-util-dev libxcb-xinerama0 libxcb-xinerama0-dev libxcb-xkb-dev \
    libxkbcommon-x11-dev feh libev-dev;

sudo apt install checkinstall curl build-essential git;

printf "\n";

git clone https://github.com/PandorasFox/i3lock-color && cd i3lock-color;
autoreconf -i && ./configure.ac;
make and sudo checkinstall --pkgname=i3lock-color --pkgversion=1;

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
