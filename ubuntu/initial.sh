#!/bin/bash
set -eoux pipefail
###
# @Github: https://github.com/Certseeds
# @Organization: SUSTech
# @Author: nanoseeds
# @Date: 2020-02-14 12:03:47
# @LastEditors: nanoseeds
# @LastEditTime: 2020-05-03 22:04:16
###
finish() {
    echo "${0} ${1} finish" || exit 1
}
main() {
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
        pip config set global.index-url https://mirrors.aliyun.com/pypi/simple
        # TODO add
        # alias sudo='sudo env PATH=$PATH'
        # to ./zshrc
        # TODO source ~/.zshrc
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
        # git clone https://gitee.com/zgq0301/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlight0ing || exit 1;
        git clone https://gitee.com/zgq0301/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh}/plugins/zsh-syntax-highlighting || exit 1

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
        # TODO source ~/.zshrc
    fi
    finish 10
    if [[ ${stage} -le 11 ]]; then
        echo "$0 stage 11 screen"
        sudo chmod 0777 /usr/bin/screen
        sudo chmod 0777 /run/screen
    fi
    finish 11
    if [[ ${stage} -le 12 ]]; then
        echo "$0 stage 12 apt-installs"
        sudo apt-get install gcc || exit 1
        sudo apt-get install g++ || exit 1
        sudo apt-get install gdb || exit 1
        sudo apt-get install zip || exit 1
        sudo apt-get install tree || exit 1
        sudo apt-get install htop || exit 1
        sudo apt-get install make || exit 1
        sudo apt-get install ffmpeg || exit 1
        sudo apt-get source glibc || exit 1
        sudo apt-get install openjdk-11-jdk || exit 1
        sudo pip install cmake==3.16.6 || exit 1
    fi
    finish 12
    if [[ ${stage} -le 13 ]]; then
        echo "$0 stage 13 install miniconda"
        wget -c https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-x86_64.sh || exit 1
        sudo chmod 0755 ./Miniconda3-latest-Linux-x86_64.sh || exit 1
        sudo ./Miniconda3-latest-Linux-x86_64.sh || exit 1
        rm ./Miniconda3-latest-Linux-x86_64.sh || exit 1
        # TODO press enter && yes now
        # TODO source ~/.zshrc
    fi
    finish 13
    if [[ ${stage} -le 14 ]]; then
        echo "$0 stage 14 conda config"
        sed -i '1i\export PATH=~/miniconda3/bin:\$PATH' ~/.zshrc || exit 1
        # TODO source ~/.zshrc
        conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free || exit 1
        conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge || exit 1
        conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda || exit 1
        conda config --set show_channel_urls yes || exit 1
        confa config --show_channel_urls yes || exit 1
    fi
    finish 14
    if [[ ${stage} -le 15 ]]; then
        sudo sed -i '/Port /c Port 2222' /etc/ssh/sshd_config
        sudo sed -i '/ListenAddress 0.0.0.0/c ListenAddress 0.0.0.0' /etc/ssh/sshd_config
        sudo sed -i '/PasswordAuthentication no/c PasswordAuthentication yes' /etc/ssh/sshd_config
        sudo service ssh restart
    fi
    finish 15
    if [[ ${stage} -le 16 ]]; then
        sudo sed -i '/Port /c Port 2222' /etc/ssh/sshd_config
        sudo sed -i '/ListenAddress 0.0.0.0/c ListenAddress 0.0.0.0' /etc/ssh/sshd_config
        sudo sed -i '/PasswordAuthentication no/c PasswordAuthentication yes' /etc/ssh/sshd_config
        sudo service ssh restart
    fi
    finish 16
    if [[ ${stage} -le 17 ]]; then
        # install dependency of opencv.
        sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"
        sudo apt update
        sudo apt-get install git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
        # install opencv
        cd ~
        wget https://codeload.github.com/opencv/opencv/tar.gz/3.4.10
        tar -vxf opencv--3.4.10.tar.gz
        mkdir build_dir
        cd build_dir
        cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local ..
        make -j6
        make install
        # then, lib is in  /usr/local/include/opencv2
    fi
    finish 17
    if [[ ${stage} -le 18 ]]; then
        # Download shellcheck newest
        envi=$(pwd)
        cd ~/
        mkdir ~/tmp_install_folder/
        wget -P ~/tmp_install_folder/ https://github.com/koalaman/shellcheck/releases/download/latest/shellcheck-latest.linux.x86_64.tar.xz
        # Extract
        tar xvf ~/tmp_install_folder/shellcheck-latest.linux.x86_64.tar.xz -C ~/tmp_install_folder
        # Make it globally available
        cp ~/tmp_install_folder/shellcheck-latest/shellcheck /usr/bin/shellcheck
        # Cleanup
        rm -r ~/tmp_install_folder
        cd "${envi}"
    fi
    finish 18
}
main 18 || exit 1
# do it after the all script!
# TODO source ~/.zshrc;
# better do it by self: "source ~/.zshrc"
