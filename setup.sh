"""

        ########        ## ######## ##      ##
        ##     ##       ## ##       ##  ##  ##
        ##     ##       ## ##       ##  ##  ##
        ########        ## ######   ##  ##  ##
        ##     ## ##    ## ##       ##  ##  ##
        ##     ## ##    ## ##       ##  ##  ##
        ########   ######  ########  ###  ###

Name:   setup.sh
Author: Bjew
Web:    www.bjew.de

This script has been highly inspired by JackHack96!
I also used some of his methods in my script here.
Please checkout his script right here:
https://github.com/JackHack96/dell-xps-9570-ubuntu-respin/blob/master/xps-tweaks.sh

"""

# Define some colors for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Get release
release=$(lsb_release -c -s)

# Check if the script is running under Ubuntu 18.04 Bionic Beaver
if [ "$release" != "bionic" ] && [ "$release" != "focal" ]; then
    echo >&2 -e "${RED}This script is made for Ubuntu 18.04/20.04!${NC}"
    exit 1
fi

# Check if the script is running as root
if [ "$EUID" -ne 0 ]; then
    echo >&2 -e "${RED}Please run this script as root!${NC}"
    exit 2
fi

# Update and upgrade
echo -e "${CYAN}Updating apt.${NC}"
apt-get -y update
apt-get -y upgrade

# Install basic tools I want to use on every machine
echo -e "${CYAN}Installing basic tools.${NC}"
apt-get -y install gnome-tweaks thunderbird timeshift alacarte cifs-utils
snap install onlyoffice-desktopeditors

"""
Following section contains choices.
I do not want to use every type of software on every machine - therefore I have to choose during script run time.
"""

# Install photo tools
echo -e "${GREEN}Do you wish to install RawTherapee?${NC}"
select yn in "Yes" "No"; do
    case $yn in
    Yes)
        apt-get -y install rawtherapee-data
        break
        ;;
    No) break ;;
    esac
done

# Install code and collaboration tools
echo -e "${GREEN}Do you wish to install code and collaboration tools (VS Code, MS Teams)?${NC}"
select yn in "Yes" "No"; do
    case $yn in
    Yes)
        snap install --classic code
        apt-get -y install maven openjdk-11-jdk build-essential libsecret-1-0 libsecret-1-dev
        break
        ;;
    No) break ;;
    esac
done

# Install dropbox
echo -e "${GREEN}Do you wish to install Dropbox?${NC}"
select yn in "Yes" "No"; do
    case $yn in
    Yes)
        apt-get -y install nautilus-dropbox
        break
        ;;
    No) break ;;
    esac
done

# Install gaming related software
echo -e "${GREEN}Do you wish to install gaming software (Discord, Steam)?${NC}"
select yn in "Yes" "No"; do
    case $yn in
    Yes)
        snap install discord
        add-apt-repository multiverse
        apt-get -y update
        apt-get -y install steam
        break
        ;;
    No) break ;;
    esac
done

# Install cure slicer for 3D printer
echo -e "${GREEN}Do you wish to install 3D printing software (Cura slicer)?${NC}"
select yn in "Yes" "No"; do
    case $yn in
    Yes)
        snap install cura-slicer
        break
        ;;
    No) break ;;
    esac
done

# Streaming sotware
echo -e "${GREEN}Do you wish to install streaming software (OBS studio)?${NC}"
select yn in "Yes" "No"; do
    case $yn in
    Yes)
        apt-get -y install ffmpeg obs-studio
        break
        ;;
    No) break ;;
    esac
done

# Update, upgrade and autoremove
echo -e "${CYAN}A final update, upgrade and autoremove.${NC}"
apt-get -y update
apt-get -y upgrade
apt-get -y autoremove

# Finish the script
echo -e "${YELLOW}Finished all tasks!${NC}"
