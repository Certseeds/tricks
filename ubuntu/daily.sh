#!/bin/bash
set -eoux pipefail
###
# @Github: https://github.com/Certseeds/tricks
# @Organization: SUSTech
# @Author: nanoseeds
# @Date: 2020-08-21 18:23:17
# @LastEditors: nanoseeds
# @LastEditTime: 2020-08-27 20:59:32
###

SHELL_FOLDER=$(
    cd "$(dirname "${0}")"
    pwd
)
main() {
    sudo chmod 0777 /usr/bin/screen
    sudo /etc/init.d/screen-cleanup start
    sudo apt update
    sudo apt upgrade -y
    source "${SHELL_FOLDER}"/set_proxy.sh
}
main
