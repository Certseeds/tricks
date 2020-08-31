#!/bin/bash
set -eoux pipefail
###
# @Github: https://github.com/Certseeds/tricks
# @Organization: SUSTech
# @Author: nanoseeds
# @Date: 2020-08-21 18:23:17
 # @LastEditors: nanoseeds
 # @LastEditTime: 2020-08-30 17:45:46
###

SHELL_FOLDER=$(
    cd "$(dirname "${0}")"
    pwd
)
main() {
    sudo chmod 0777 /usr/bin/screen
    sudo /etc/init.d/screen-cleanup start
    sudo apt update -y
    sudo apt upgrade -y
    sudo /etc/init.d/ssh restart
    source "${SHELL_FOLDER}"/set_proxy.sh
}
main
