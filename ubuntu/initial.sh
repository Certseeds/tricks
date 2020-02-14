#!/bin/bash
###
 # @Github: https://github.com/Certseeds
 # @Organization: SUSTech
 # @Author: nanoseeds
 # @Date: 2020-02-14 12:03:47
 # @LastEditors  : nanoseeds
 # @LastEditTime : 2020-02-14 16:28:11
 ###
set -euxo pipefail
finish(){
  echo "${0} ${1} finish"
}
main()
{
  echo "$0 stage 0 init"
  stage=$1
  echo ${stage}
if [[ ${stage} -le 1 ]]; then
  echo "$0 stage 1 backup"
  sudo cp /etc/apt/sources.list /etc/apt/sources.list_backup
fi
finish 1
if [[ ${stage} -le 2 ]]; then
  echo "$0 stage 2 replace"
  sudo sed -i "s/archive.ubuntu.com/mirrors.aliyun.com/g" /etc/apt/sources.list
fi
finish 2
if [[ ${stage} -le 3 ]]; then
  echo "$0 stage 3 update"
  sudo apt-get update
fi
finish 3
if [[ ${stage} -le 4 ]]; then
  echo "$0 stage 4 upgrade"
  sudo apt-get upgrade
fi
finish 4
if [[ ${stage} -le 5 ]]; then
  echo "$0 stage 5 shells"
  echo $SHELL
  sudo cat /etc/shells
fi
finish 5
if [[ ${stage} -le 6 ]]; then
  echo "$0 stage 6 ALL SHELLS"
  sudo apt-get install zsh
  sudo chsh -s /bin/zsh
fi
finish 6
if [[ ${stage} -le 7 ]]; then
  echo "$0 stage 7 download oh-my-zsh itself"
  ## change the paths by yourself
  git clone https://gitee.com/Infinite_Heng/ohmyzsh.git ~/.oh-my-zsh --depth=1
  sudo cp -i ./.zshrc ~/.zshrc
  # cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
fi
finish 7
if [[ ${stage} -le 8 ]]; then
  echo "$0 stage 8 download zsh-syntax-highlighting itself"
  git clone https://gitee.com/zgq0301/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi
finish 8
if [[ ${stage} -le 9 ]]; then
  echo "$0 stage 9 download zsh-autosuggestions itself"
  git clone https://gitee.com/itgeeker/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh}/plugins/zsh-autosuggestions
fi
finish 9
if [[ ${stage} -le 10 ]]; then
  echo "$0 stage 10 chmods"
  sudo chmod 0755 ~/.oh-my-zsh
  sudo chmod 0755 ~/.oh-my-zsh/custom/plugins
  sudo chmod 0755 ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
  sudo chmod 0755 ~/.oh-my-zsh/plugins
  sudo chmod 0755 ~/.oh-my-zsh/plugins/git
  sudo chmod 0755 ~/.oh-my-zsh/plugins/z
  sudo chmod 0755 ~/.oh-my-zsh/plugins/zsh-autosuggestions
fi
finish 10
}
main 11
# better do it by self: "source ~/.zshrc"