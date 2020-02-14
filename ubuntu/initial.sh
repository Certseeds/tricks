#!/bin/bash
###
 # @Github: https://github.com/Certseeds
 # @Organization: SUSTech
 # @Author: nanoseeds
 # @Date: 2020-02-14 12:03:47
 # @LastEditors  : nanoseeds
 # @LastEditTime : 2020-02-14 13:47:01
 ###
set -euxo pipefail
main(){
  echo "$0 stage 0 init"
  stage=$1
  echo ${stage}
if [[${stage} -le 1 ]] then
  echo "$0 stage 1 backup"
  sudo cp /etc/apt/sources.list /etc/apt/sources.list_backup
fi
if [[${stage} -le 2 ]] then
  echo "$0 stage 2 replace"
  sudo sed -i "s/archive.ubuntu.com/mirrors.aliyun.com/g" /etc/apt/sources.list
fi
if [[${stage} -le 3 ]] then
  echo "$0 stage 3 update"
  sudo apt-get update
fi
if [[${stage} -le 4 ]] then
  echo "$0 stage 4 upgrade"
  sudo apt-get upgrade
fi
if [[${stage} -le 5 ]] then
  echo "$0 stage 5 shells"
  echo $SHELL
  cat /etc/shells  
  echo "$0:ALL SHELLS"
  sudo apt-get install zsh
  chsh -s /bin/zsh
fi
}
echo "?"
main 114514
