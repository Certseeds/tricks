#!/bin/bash
set -eoux pipefail
###
# @Github: https://github.com/Certseeds/tricks
# @Organization: SUSTech
# @Author: nanoseeds
# @Date: 2020-03-14 21:50:12
 # @LastEditors: nanoseeds
 # @LastEditTime: 2020-05-26 20:30:04
###
main() {
    origin_path=$(pwd)
    cd "${1}"
    list=($(cat ./names.txt))
    for i in ${list[@]}; do
        touch "${i}"
        echo "${i}" | base64 >"./${i}"
    done
    cd "${origin_path}"
}
main "${1}"
# main ./ for default
