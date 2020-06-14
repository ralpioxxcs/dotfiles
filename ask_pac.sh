#!/bin/bash

COLOR_NONE='\033[0m'
COLOR_BLACK='\033[0;30m'
COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_BROWN='\033[0;33m'
COLOR_BLUE='\033[0;34m'
COLOR_PURPLE='\033[0;35m'
COLOR_CYAN='\033[0;36m'
COLOR_LIGHT_GRAY='\033[0;37m'
COLOR_DARK_GRAY='\033[1;30m'
COLOR_LIGHT_RED='\033[1;31m'
COLOR_LIGHT_GREEN='\033[1;32m'
COLOR_YELLOW='\033[1;33m'
COLOR_LIGHT_BLUE='\033[1;34m'
COLOR_LIGHT_PURPLE='\033[1;35m'
COLOR_LIGHT_CYAN='\033[1;36m'
COLOR_WHITE='\033[1;37m'

check_package() {
  local value=$1
  echo "check ${value} installed ..."
  REQUIRED_PKG=${value}
  PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
  echo Checking for $REQUIRED_PKG: $PKG_OK
  # if is not installed
  if [ "" = "$PKG_OK" ]; then
    retVal="False"
  else
    retVal="True"
  fi
}


echo -e "check shell sciprt"
check_package "multitail"


if [ "${retVal}" = "True" ]; then
    echo -e "${COLOR_GREEN}true${COLOR_NONE}"
elif [ "${retVal}" = "False" ]; then
    echo "${COLOR_RED}false${COLOR_NONE}"
fi