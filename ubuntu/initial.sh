#!/bin/bash
set -eoux pipefail
###
# @Github: https://github.com/Certseeds/tricks
# @Organization: SUSTech
# @Author: nanoseeds
# @Date: 2020-02-14 12:03:47
# @LastEditors: nanoseeds
# @LastEditTime: 2020-11-09 23:10:02
###
finish() {
    echo "${0} ${1} finish"
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
    sudo cp /etc/apt/sources.list /etc/apt/sources.list_backup
    sudo cp ./sources_aliyun_1804.list.backup /etc/apt/sources.list
    main_0
}
main_2() {
    sudo apt install git build-essential curl wget screen gdb zip tree screenfetch \
        make ffmpeg openjdk-11-jdk libssl-dev openssl net-tools vim xclip \
        proxychains4 exiftool rename aria2 manpages-dev python3-pip keychain \
        lsb-core openssh-client openssh-server traceroute htop pigz maven -y
    if [[ ! -d "${HOME}/.pip" ]]; then
        mkdir "${HOME}"/.pip
    fi
    if [ ! -f "/etc/proxychains4.conf" ]; then
        touch /etc/proxychains4.conf
    fi
    cp ./pip.conf.backup "${HOME}"/.pip/pip.conf
    sudo chmod 0755 "${HOME}"/.pip/pip.conf
    #pip3 config list
    sudo pip3 install cmake
}
main_3() {
    # download oh-my-zsh
    sudo apt install zsh -y
    sudo chsh -s "$(which zsh)"
    sudo usermod -s "$(which zsh)" "$(whoami)"
    if [ -d "${HOME}/.oh-my-zsh" ]; then
        rm -rf "${HOME}/.oh-my-zsh"
    fi
    proxychains4 git clone https://github.com/ohmyzsh/ohmyzsh.git \
        "${HOME}"/.oh-my-zsh --depth=1
    proxychains4 git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        "${HOME}"/.oh-my-zsh/plugins/zsh-syntax-highlighting --depth=1
    proxychains4 git clone https://github.com/zsh-users/zsh-autosuggestions.git \
        "${HOME}"/.oh-my-zsh/plugins/zsh-autosuggestions --depth=1
    {
        sudo chmod 0755 "${HOME}"/.oh-my-zsh
        sudo chmod 0755 "${HOME}"/.oh-my-zsh/custom/plugins
        sudo chmod 0755 "${HOME}"/.oh-my-zsh/plugins
        sudo chmod 0755 "${HOME}"/.oh-my-zsh/plugins/z
        sudo chmod 0755 "${HOME}"/.oh-my-zsh/plugins/git
        sudo chmod 0755 "${HOME}"/.oh-my-zsh/plugins/zsh-syntax-highlighting
        sudo chmod 0755 "${HOME}"/.oh-my-zsh/plugins/zsh-autosuggestions
    }
    sudo cp -i ./zshrc.backup "${HOME}"/.zshrc
    #
}
main_4() {
    # anaconda
    ANACONDA="Anaconda3-2020.07-Linux-x86_64.sh"
    proxychains4 wget -c https://repo.anaconda.com/archive/"${ANACONDA}" \
        --user-agent="Mozilla/5.0 (X11;U;Linux i686;en-US;rv:1.9.0.3) Geco/2008092416 Firefox/3.0.3" \
        --no-check-certificate
    sudo chmod 0755 ./"${ANACONDA}"
    sudo ./"${ANACONDA}"
    rm ./"${ANACONDA}"
    # TODO press enter && yes now
    # TODO source ~/.zshrc
}
main_5() {
    # set origin of anaconda
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda
    conda config --set show_channel_urls yes
    conda config --show_channel_urls yes
}
main_6() {
    #wsl set port
    # use 2222,3333 and so on.
    sudo sed -i '/Port /c Port 2222' /etc/ssh/sshd_config
    sudo sed -i '/ListenAddress 0.0.0.0/c ListenAddress 0.0.0.0' /etc/ssh/sshd_config
    sudo sed -i '/PasswordAuthentication no/c PasswordAuthentication yes' /etc/ssh/sshd_config
    sudo service ssh restart
}
main_7() {
    envi=$(pwd)
    SHELLCHECK="shellcheck-latest.linux.x86_64.tar.xz"
    cd "${HOME}"/
    if [[ ! -d "${HOME}/tmp_install_folder/" ]]; then
        mkdir "${HOME}"/tmp_install_folder/
    else
        rm -rf "${HOME}"/tmp_install_folder/
    fi
    proxychains4 wget -P "${HOME}"/tmp_install_folder/ \
        https://github.com/koalaman/shellcheck/releases/download/latest/"${SHELLCHECK}"
    # Extract
    tar xvf "${HOME}"/tmp_install_folder/"${SHELLCHECK}" -C "${HOME}"/tmp_install_folder
    # Make it globally available
    sudo cp "${HOME}"/tmp_install_folder/shellcheck-latest/shellcheck /usr/bin/shellcheck
    # Cleanup
    rm -r "${HOME}"/tmp_install_folder
    cd "${envi}"
}
main_8() {
    # install dependency of opencv
    sudo add-apt-repository "deb http://mirrors.aliyun.com/ubuntu/ xenial-security main"
    main_0
    sudo apt install libgtk2.0-dev pkg-config libavcodec-dev \
        libavformat-dev libswscale-dev python-dev python-numpy libtbb2 \
        libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev \
        libdc1394-22-dev -y
    # download
    {
        cd "${HOME}"
        proxychains4 wget https://codeload.github.com/opencv/opencv/tar.gz/3.4.10
        tar -vxf opencv--3.4.10.tar.gz
        if [[ ! -d "build_dir" ]]; then
            mkdir build_dir
        fi
        cd build_dir
        cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local ..
        #make -j "$(cat /proc/cpuinfo | grep "processor" | wc -l)"
        make -j "$(nproc)"
        make install
        # TODO delete last filess
        # then, lib is in  /usr/local/include/opencv2
    }
}
main_9() {
    # set go
    envi=$(pwd)
    cd "${HOME}"
    GO_FILE_NAME="go1.15.linux-amd64.tar.gz"
    pcf wget https://golang.org/dl/"${GO_FILE_NAME}"
    sudo tar -xzf "${GO_FILE_NAME}" -C /usr/local/
    rm "${GO_FILE_NAME}"
    # add GOPATH for /etc/profile and "${HOME}"/.zshrc now
    cd "${envi}"
}
main_10() {
    #only for vmware
    sudo apt install open-vm-tools -y
    # sudo apt install open-vm-tools-dkms -y
    sudo apt install open-vm-tools-desktop -y
    {
        proxychains4 git clone https://github.com/rasa/vmware-tools-patches.git
        cd vmware-tools-patches
        . ./setup.sh
        ./download-tools.sh latest
        ./untar-and-patch.sh
        ./compile.sh
    }
    {
        sudo modprobe vmhgfs #检测是否存在
        lsmod | grep vmhgfs
        sudo mkdir /mnt/hgfs　#不存在要用接下来两条挂载
        sudo mount -t vmhgfs .host:/ /mnt/hgfs
    }

}
main_11() {
    #download python2 and ryus
    sudo apt-get install python2 mininet python3-ryu iputils-arping -y
    #`python2` names `python` in ubuntu1804 and elders.
}
main_12() {
    main_version_of_nodejs=14
    curl -sL https://deb.nodesource.com/setup_"${main_version_of_nodejs}".x | sudo -E bash -
    sudo apt install -y nodejs
}
main_13(){
    ln -s "$(pwd)"/zshrc.backup "${HOME}"/.zshrc
}
main_114514() {
    sudo apt autoremove
    sudo apt autoclean
    sudo apt clean
}
main_index() {
    main_0
    echo "$0 stage 0 init"
    for index in "$@"; do
        echo "stage ${index} init"
        main_${index}
        finish ${index}
    done
    main_114514
    echo "main_index over"
}
main_index 4 5
# do it after the all script!
# TODO source ~/.zshrc;
# better do it by self: "source ~/.zshrc"
