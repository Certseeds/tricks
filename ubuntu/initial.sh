#!/bin/bash
set -eoux pipefail
###
 # @Github: https://github.com/Certseeds
 # @Organization: SUSTech
 # @Author: nanoseeds
 # @Date: 2020-02-14 12:03:47
 # @LastEditors  : nanoseeds
 # @LastEditTime : 2020-02-14 20:34:33
 ###
finish(){
  echo "${0} ${1} finish" || exit 1
}
main()
{
  echo "$0 stage 0 init"
  stage=$1
  echo ${stage}
if [[ ${stage} -le 1 ]]; then
  echo "$0 stage 1 backup"
  sudo cp /etc/apt/sources.list /etc/apt/sources.list_backup || exit 1
fi
finish 1
if [[ ${stage} -le 2 ]]; then
  echo "$0 stage 2 replace"
  sudo sed -i "s/archive.ubuntu.com/mirrors.aliyun.com/g" /etc/apt/sources.list || exit 1
fi
finish 2
if [[ ${stage} -le 3 ]]; then
  echo "$0 stage 3 update"
  sudo apt-get update || exit 1
fi
finish 3
if [[ ${stage} -le 4 ]]; then
  echo "$0 stage 4 upgrade"
  sudo apt-get upgrade || exit 1
fi
finish 4
if [[ ${stage} -le 5 ]]; then
  echo "$0 stage 5 shells"
  echo $SHELL
  sudo cat /etc/shells || exit 1
fi
finish 5
if [[ ${stage} -le 6 ]]; then
  echo "$0 stage 6 ALL SHELLS"
  sudo apt-get install zsh || exit 1
  sudo chsh -s /bin/zsh || exit 1
fi
finish 6
if [[ ${stage} -le 7 ]]; then
  echo "$0 stage 7 download oh-my-zsh itself"
  ## change the paths by yourself
  git clone https://gitee.com/Infinite_Heng/ohmyzsh.git ~/.oh-my-zsh --depth=1 || exit 1
  sudo cp -i ./.zshrc ~/.zshrc || exit 1
  # cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
fi
finish 7
if [[ ${stage} -le 8 ]]; then
  echo "$0 stage 8 download zsh-syntax-highlighting itself"
  git clone https://gitee.com/zgq0301/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlight0ing || exit 1
fi
finish 8
if [[ ${stage} -le 9 ]]; then
  echo "$0 stage 9 download zsh-autosuggestions itself"
  git clone https://gitee.com/itgeeker/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh}/plugins/zsh-autosuggestions || exit 1
fi
finish 9
if [[ ${stage} -le 10 ]]; then
  echo "$0 stage 10 chmods"
  sudo chmod 0755 ~/.oh-my-zsh || exit 1
  sudo chmod 0755 ~/.oh-my-zsh/custom/plugins || exit 1
  sudo chmod 0755 ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting || exit 1
  sudo chmod 0755 ~/.oh-my-zsh/plugins || exit 1
  sudo chmod 0755 ~/.oh-my-zsh/plugins/git || exit 1
  sudo chmod 0755 ~/.oh-my-zsh/plugins/z || exit 1
  sudo chmod 0755 ~/.oh-my-zsh/plugins/zsh-autosuggestions || exit 1
fi
finish 10
if [[ ${stage} -le 11 ]]; then
  echo "$0 stage 11 screen"
  sudo chmod 0777 /usr/bin/screen
  sudo chmod 0777 /run/screen
fi
finish 11
}
main 11 || exit 1
# better do it by self: "source ~/.zshrc"