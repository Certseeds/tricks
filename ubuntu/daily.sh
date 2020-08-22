#!/bin/bash
set -eoux pipefail
###
 # @Github: https://github.com/Certseeds/tricks
 # @Organization: SUSTech
 # @Author: nanoseeds
 # @Date: 2020-08-21 18:23:17
 # @LastEditors: nanoseeds
 # @LastEditTime: 2020-08-22 20:21:33
### 

SHELL_FOLDER=$(cd "$(dirname "${0}")";pwd)

. "${SHELL_FOLDER}"/set_proxy.sh
sudo chmod 0777 /usr/bin/screen
sudo /etc/init.d/screen-cleanup start