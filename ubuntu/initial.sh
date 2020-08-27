#!/bin/bash
set -eoux pipefail
###
# @Github: https://github.com/Certseeds
# @Organization: SUSTech
# @Author: nanoseeds
# @Date: 2020-02-14 12:03:47
# @LastEditors: nanoseeds
# @LastEditTime: 2020-08-27 21:10:12
###
finish() {
    echo "${0} ${1} finish" || exit 1
}
add_apt_vscode() {
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >microsoft.gpg
    sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
}
main_0() {
    sudo chmod 0777 /usr/bin/screen
    sudo /etc/init.d/screen-cleanup start
    sudo apt update -y
    sudo apt upgrade -y
}
main_1() {
    # backup so
    sudo cp /etc/apt/sources.list /etc/apt/sources.list_backup || exit 1
    sudo cp ./sources_aliyun_2004.list.backup /etc/apt/sources.list
    main_0
}
main_2() {
    sudo apt install build-essential curl wget screen gdb zip tree htop \
        make ffmpeg openjdk-11-jdk libssl-dev openssl net-tools \
        exiftool rename aria2 manpages-dev python3-pip -y
    if [[ ! -d "${HOME}/.pip" ]]; then
        mkdir ~/.pip
    fi
    cp ./pip.conf.backup ~/.pip/pip.conf
    sudo chmod 0755 ~/.pip/pip.conf
    sudo pip3 install cmake
}
main_3() {
    # download oh-my-zsh
    sudo apt install zsh -y
    sudo chsh -s "$(which zsh)"
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh --depth=1
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        "${ZSH_CUSTOM:-~/.oh-my-zsh}"/plugins/zsh-syntax-highlighting --depth=1 || exit 1
    git clone https://github.com/zsh-users/zsh-autosuggestions.git \
        "${ZSH_CUSTOM:-~/.oh-my-zsh}"/plugins/zsh-autosuggestions --depth=1 || exit 1
    {
        sudo chmod 0755 ~/.oh-my-zsh || exit 1
        sudo chmod 0755 ~/.oh-my-zsh/custom/plugins || exit 1
        sudo chmod 0755 ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting || exit 1
        sudo chmod 0755 ~/.oh-my-zsh/plugins || exit 1
        sudo chmod 0755 ~/.oh-my-zsh/plugins/git || exit 1
        sudo chmod 0755 ~/.oh-my-zsh/plugins/z || exit 1
        sudo chmod 0755 ~/.oh-my-zsh/plugins/zsh-autosuggestions || exit 1
    }
    sudo cp -i ./zshrc.backup ~/.zshrc
    #
}
main_4() {
    # anaconda
    ANACONDA="Anaconda3-2020.07-Linux-x86_64.sh"
    wget -c https://repo.anaconda.com/archive/"${ANACONDA}" || exit 1
    sudo chmod 0755 ./"${ANACONDA}" || exit 1
    sudo ./"${ANACONDA}" || exit 1
    rm ./"${ANACONDA}" || exit 1
    # TODO press enter && yes now
    # TODO source ~/.zshrc
}
main_5() {
    # set origin of anaconda
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free || exit 1
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge || exit 1
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda || exit 1
    conda config --set show_channel_urls yes || exit 1
    conda config --show_channel_urls yes || exit 1
}
main_6() {
    #wsl set port
    sudo sed -i '/Port /c Port 2222' /etc/ssh/sshd_config
    sudo sed -i '/ListenAddress 0.0.0.0/c ListenAddress 0.0.0.0' /etc/ssh/sshd_config
    sudo sed -i '/PasswordAuthentication no/c PasswordAuthentication yes' /etc/ssh/sshd_config
    sudo service ssh restart
}
main_7() {
    envi=$(pwd)
    SHELLCHECK="shellcheck-latest.linux.x86_64.tar.xz"
    cd ~/
    if [[ ! -d "${HOME}/tmp_install_folder/" ]]; then
        mkdir ~/tmp_install_folder/
    fi
    wget -P ~/tmp_install_folder/ \
        https://github.com/koalaman/shellcheck/releases/download/latest/"${SHELLCHECK}"
    # Extract
    tar xvf ~/tmp_install_folder/"${SHELLCHECK}" -C ~/tmp_install_folder
    # Make it globally available
    cp ~/tmp_install_folder/shellcheck-latest/shellcheck /usr/bin/shellcheck
    # Cleanup
    rm -r ~/tmp_install_folder
    cd "${envi}"
}
main_8() {
    # install dependency of opencv
    sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"
    main_0
    sudo apt install libgtk2.0-dev pkg-config libavcodec-dev \
        libavformat-dev libswscale-dev python-dev python-numpy libtbb2 \
        libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev \
        libdc1394-22-dev -y
    # download
    {
        cd ~
        wget https://codeload.github.com/opencv/opencv/tar.gz/3.4.10
        tar -vxf opencv--3.4.10.tar.gz
        if [[ ! -d "build_dir" ]]; then
            mkdir build_dir
        fi
        cd build_dir
        cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local ..
        make -j "$(cat /proc/cpuinfo | grep "processor" | wc -l)"
        make install
        # TODO delete last filess
        # then, lib is in  /usr/local/include/opencv2
    }
}
main_9() {
    # set go
    envi=$(pwd)
    cd ~
    GO_FILE_NAME="go1.15.linux-amd64.tar.gz"
    wget https://golang.org/dl/"${GO_FILE_NAME}"
    sudo tar -xzf "${GO_FILE_NAME}" -C /usr/local/
    rm "${GO_FILE_NAME}"
    # add GOPATH for /etc/profile and ~/.zshrc now
    cd "${envi}"
}
main_index() {
    echo "$0 stage 0 init"
    for index in "$@"; do
        echo "stage ${index} init"
        main_${index}
        finish ${index}
    done
    echo "main_index over"
}
main_index 2 3 7
# do it after the all script!
# TODO source ~/.zshrc;
# better do it by self: "source ~/.zshrc"
