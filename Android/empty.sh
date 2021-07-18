#!/bin/bash
set -eoux pipefail
###
# @Github: https://github.com/Certseeds/tricks
# @Organization: SUSTech
# @Author: nanoseeds
# @Date: 2020-03-14 21:50:12
 # @LastEditors: nanoseeds
 # @LastEditTime: 2021-07-18 18:15:14
###
main() {
    origin_path=$(pwd)
    cd "${1}"
    grep -v '^ *#' <./names.txt | while IFS= read -r line; do
        echo "Line: $line"
        touch "${line}"
        echo "${line}" | base64 | md5sum >"./${line}"
        echo "${line}" | md5sum | base64 >>"./${line}"
        echo "${line}" | base64 | base64 >>"./${line}"
        echo "${line}" | md5sum | md5sum >>"./${line}"

    done
    cd "${origin_path}"
}
main "${1}"
# main ./ for default
