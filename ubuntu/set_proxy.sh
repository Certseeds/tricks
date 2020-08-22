#!/bin/bash
set -eo pipefail
###
 # @Github: https://github.com/Certseeds/tricks
 # @Organization: SUSTech
 # @Author: nanoseeds
 # @Date: 2020-08-21 15:00:50
 # @LastEditors: nanoseeds
 # @LastEditTime: 2020-08-22 20:30:44
### 
hostip=$(cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }')
wslip=$(hostname -I | awk '{print $1}')
httpport=4782
sockport=4782

PROXY_HTTP="http://${hostip}:${httpport}"
PROXY_SOCK="http://${hostip}:${sockport}"

set_proxy(){
    export http_proxy="${PROXY_HTTP}"
    export HTTP_PROXY="${PROXY_HTTP}"

    export https_proxy="${PROXY_HTTP}"
    export HTTPS_proxy="${PROXY_HTTP}"
    
    git config --global http.proxy "${PROXY_SOCK}"
    git config --global https.proxy "${PROXY_SOCK}"

    export ALL_PROXY="${PROXY_HTTP}"
    export all_proxy=${PROXY_HTTP}
}

unset_proxy(){
    unset http_proxy
    unset HTTP_PROXY

    unset https_proxy
    unset HTTPS_PROXY

    git config --global --unset http.proxy
    git config --global --unset https.proxy

    unset ALL_PROXY
    unset all_proxy
}

test_setting(){
    echo "Host ip:" ${hostip}
    echo "WSL ip:" ${wslip}
    echo "Current proxy:" ${PROXY_HTTP}
    echo "socks5 proxy": ${PROXY_SOCK}
}
make_history(){
    mv ~/.zsh_history ~/.zsh_history_bad
    touch ~/.zsh_history
}

test_setting
unset_proxy
set_proxy
test_setting
#make_history
