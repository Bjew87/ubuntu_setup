# setup file
# created by Bjew87
# inspired by https://github.com/JackHack96/dell-xps-9570-ubuntu-respin/blob/master/xps-tweaks.sh

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

release=$(lsb_release -c -s)

# Check if the script is running under Ubuntu 18.04 Bionic Beaver
if [ "$release" != "bionic" ] && [ "$release" != "focal" ] ; then
    >&2 echo -e "${RED}This script is made for Ubuntu 18.04/20.04!${NC}"
    exit 1
fi

# Check if the script is running as root
if [ "$EUID" -ne 0 ]; then
    >&2 echo -e "${RED}Please run this script as root!${NC}"
    exit 2
fi

#
echo -e "${GREEN}Updating apt."

apt-get -y update
apt-get -y upgrade

# Install photo tools
echo -e "${GREEN}Do you wish to install RawTherapee?${NC}"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) apt -y install rawtherapee-data; break;;
        No ) break;;
    esac
done

# Install code and collaboration tools
echo -e "${GREEN}Do you wish to install code and collaboration tools (VS Code, MS Teams)?${NC}"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) snap install --classic code; break;;
        No ) break;;
    esac
done

# finished
echo -e "${GREEN}Finished all tasks!${NC}"
