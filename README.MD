# Installer Scripts
This repository contains installer scripts for various online resources. The aim here is to do the installation of such resources in one command by letting these scripts handle the whole installation procedure, that is installing the dependencies etc.

The scripts are written in `bash`. They will remove the fetched resources and other auxiliary packages, installed during execution, after the completion of the installation.

**Currently, these scripts are aimed at Debian systems and its derivatives, such as Ubuntu etc., only.**

The installed packages are logged in the `/opt/installer-scripts.log` file after installation.

## List of Scripts:
The following installer scripts are currently present:
* betterlockscreen - [pavanjadhaw/betterlockscreen](https://github.com/pavanjadhaw/betterlockscreen)