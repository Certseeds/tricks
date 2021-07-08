#!/bin/bash
set -eoux pipefail
###
# @Github: https://github.com/Certseeds/tricks
# @Organization: SUSTech
# @Author: nanoseeds
# @Date: 2020-02-14 12:03:47
 # @LastEditors: nanoseeds
 # @LastEditTime: 2021-07-01 19:40:47
###
readonly USER_AGENT="Mozilla/5.0 (X11;U;Linux i686;en-US;rv:1.9.0.3) Geco/2008092416 Firefox/3.0.3"
readonly UBUNTU_VERSION="$(lsb_release -c | sed 's/Codename://g' | xargs)"
finish() {
    echo "${0} ${1} finish"
}
main_microsoft() {
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >microsoft.gpg
    sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
}
main_vscode() {
    main_microsoft
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo rm microsoft.gpg
    ## Install
    sudo apt update
    sudo apt install code
}
main_msedge() {
    ## Setup
    main_microsoft
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
    sudo rm microsoft.gpg
    ## Install
    sudo apt update
    sudo apt install microsoft-edge-dev
}
main_0() {
    #sudo chmod 0777 /usr/bin/screen
    # sudo /etc/init.d/screen-cleanup start
    sudo apt update -y
    sudo apt upgrade -y
}
main_1() {
    # backup so
    sudo mv /etc/apt/sources.list /etc/apt/sources.list.backup
    #sudo ln -s "$(pwd)"/source_aliyun_1804.list /etc/apt/sources.list # this seems do not work on wsl
    sudo cp "$(pwd)"/source_aliyun_1804.list /etc/apt/sources.list
    main_0
}
main_build() {
    sudo apt install git build-essential manpages-dev \
        make ffmpeg libssl-dev openssl net-tools vim xclip \
        curl wget screen gdb zip tree neofetch transmission \
        proxychains4 exiftool rename aria2 manpages-dev keychain \
        lsb-core openssh-client openssh-server traceroute htop pigz -y
    if [[ -f "/etc/proxychains4.conf" ]]; then
        rm /etc/proxychains4.conf
    fi
    sudo ln -s "$(pwd)"/proxychains4.conf /etc/proxychains4.conf
}
main_newergcc() {
    sudo add-apt-repository ppa:ubuntu-toolchain-r/test
    sudo apt-get update
    readonly GCC_VERSION=11
    sudo apt-get install gcc-"${GCC_VERSION}" g++-"${GCC_VERSION}"
    gcc-"${GCC_VERSION}" --version
}
main_cmake() {
    sudo apt install apt-transport-https ca-certificates gnupg software-properties-common wget
    wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null
    sudo apt-add-repository "deb https://apt.kitware.com/ubuntu/ ${UBUNTU_VERSION} main"
    sudo apt update
    sudo apt-cache policy cmake
    sudo apt-cache policy cmake-data
    # readonly CMAKE_VERSION="3.19.5-0kitware1ubuntu20.04.1" # for ubuntu 2004
    readonly CMAKE_VERSION="3.19.5-0kitware1" # for ubuntu 1804
    sudo apt install cmake-data="${CMAKE_VERSION}" cmake="${CMAKE_VERSION}"
    sudo apt-mark hold cmake cmake-data
}
main_python3() {
    sudo apt install python3-pip
    mkdir -p "${HOME}"/.pip
    readonly pip_file_name="${HOME}/.pip/pip/conf"
    if [[ -f "${pip_file_name}" ]]; then
        mv "${pip_file_name}" "${pip_file_name}.back"
    fi
    ln -s "$(pwd)"/pip.conf "${pip_file_name}"
    sudo chmod 0755 "${pip_file_name}"
    sudo pip3 install numpy
}
main_pdftotext() {
    sudo apt install libpoppler-cpp-dev pkg-config
    pip3 install pdftotext         # then can import pdftotext
    sudo apt install poppler-utils # then can run `pdftotext`
}
main_jdk_mvn() {
    sudo apt install openjdk-11-jdk openjdk-8-jdk maven
    mkdir -p "/etc/maven"
    readonly settings_xml="/etc/maven/settings.xml"
    if [[ -f "${settings_xml}" ]]; then
        mv "${settings_xml}" "${settings_xml}.backup"
    fi
    sudo ln -s "$(pwd)"/settings.xml "${settings_xml}"
    sudo update-alternatives --display java
    sudo update-alternatives --config java
    sudo update-alternatives --config javac
}
main_texlive() {
    mkdir -p "${HOME}"/zsh_include
    sudo ln -s "$(pwd)"/zsh_include/texlive.sh "${HOME}"/zsh_include/texlive.sh
    readonly origin="$(pwd)"
    mkdir -p ./texlive
    mkdir -p /media/tex
    sudo mount -t auto -o loop ./texlive.iso /media/tex
    cd /media/tex
    sudo ./install-tl
    #! then should input  `I`
    sudo umount /media/tex
    sudo rm -r /media/tex
    cd "${origin}"
}
main_git() {
    cp ./.gitconfig "${HOME}"/.gitconfig
    mkdir -p "${HOME}"/template
    sudo ln -s "$(pwd)"/.gitcommit "${HOME}"/template/.gitcommit
}
main_githubcli() {
    sudo apt install software-properties-common
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
    sudo apt-add-repository https://cli.github.com/packages
    sudo apt update
    sudo apt install gh
}
main_graphcard() {
    # fuck `graphics-drivers`, it make 440 shortcut for 450, and 430 shortcut for 440, make drivers can not use at all.
    ls
    # fuck nvidia, in driver 440.100 does not match 440.33, can you believe?
}
main_ohmyzsh() {
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
    sudo ln -s "$(pwd)"/.zshrc "${HOME}"/.zshrc
    #
}
main_intelmkl() {
    readonly origin="$(pwd)"
    mkdir -p ./intelmkl
    cd ./intelmkl
    wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB \
        --user-agent="${USER_AGENT}" \
        --no-check-certificate
    sudo apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
    echo "deb https://apt.repos.intel.com/oneapi all main" | sudo tee /etc/apt/sources.list.d/oneAPI.list
    # or `sudo add-apt-repository "deb https://apt.repos.intel.com/oneapi all main"`
    sudo apt update
    sudo apt install intel-oneapi-mkl intel-oneapi-mkl-devel
    cd "${origin}"
    rm -rf ./intelmkl
}
main_anaconda() {
    # anaconda
    readonly ANACONDA="Anaconda3-2020.07-Linux-x86_64.sh"
    proxychains4 wget -c https://repo.anaconda.com/archive/"${ANACONDA}" \
        --user-agent="${USER_AGENT}" \
        --no-check-certificate
    sudo chmod 0755 ./"${ANACONDA}"
    sudo ./"${ANACONDA}"
    rm ./"${ANACONDA}"
    # TODO press enter && yes now
    # TODO source ~/.zshrc
    sudo ln -s "$(pwd)"/zsh_include/anaconda3.sh "${HOME}"/zsh_include/miniconda3.sh
}
main_miniconda() {
    mkdir -p "${HOME}"/zsh_include
    readonly MINICONDA="Miniconda3-py39_4.9.2-Linux-x86_64.sh"
    wget -c https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/"${MINICONDA}" \
        --user-agent="${USER_AGENT}" \
        --no-check-certificate
    sudo chmod 0755 ./"${MINICONDA}"
    ./"${MINICONDA}"
    rm ./"${MINICONDA}"
    sudo ln -s "$(pwd)"/zsh_include/miniconda3.sh "${HOME}"/zsh_include/miniconda3.sh
}
main_conda() {
    sudo ln -s "$(pwd)"/.condarc "${HOME}"/.condarc
    conda create -n origin python=3.6
    conda create -n pytorch python=3.8
    conda condif --show
    conda update --all
    #   conda install pytorch==1.7.1 torchvision==0.8.2 torchaudio==0.7.2 cudatoolkit=10.2 -c pytorch
}
main_condaconfig() {
    # set origin of anaconda
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda
    conda config --set show_channel_urls yes
    conda config --show_channel_urls yes
}
main_cuda() {
    #! FIRST, install driver!!
    # wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin
    sudo cp cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
    # wget https://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/cuda-repo-ubuntu1804-10-2-local-10.2.89-440.33.01_1.0-1_amd64.deb
    sudo apt install -y ./cuda/cuda-repo-ubuntu1804-10-2-local-10.2.89-440.33.01_1.0-1_amd64.deb
    sudo apt install -y ./cuda/cuda-repo-ubuntu1804-10-2-local_10.2.1-1_amd64.deb
    sudo apt install -y ./cuda/cuda-repo-ubuntu1804-10-2-local_10.2.2-1_amd64.deb
    sudo apt install -y ./cuda/libcudnn8_8.1.1.33-1+cuda10.2_amd64.deb
    sudo apt install -y ./cuda/libcudnn8-dev_8.1.1.33-1+cuda10.2_amd64.deb
    sudo apt-key add /var/cuda-repo-10-2-local-10.2.89-440.33.01/7fa2af80.pub
    sudo apt update
    sudo apt -y install cuda
}
main_sshd() {
    sudo chown -R 1000:1000 "${HOME}"/.ssh/* # make sure all filex own by normal user
    sudo chmod 0700 "${HOME}"/.ssh
    sudo chmod 0600 "${HOME}"/.ssh/*
    sudo mv /etc/ssh/sshd_config /etc/ssh/sshd_config.backup
    sudo ln -s "$(pwd)"/sshd_config /etc/ssh/sshd_config
    # do not forget to ln a *.pub as authorized_keys as login pub key
}
main_LD_LIBRARY_PATH() {
    mkdir -p "${HOME}"/zsh_include
    sudo ln -s "$(pwd)"/zsh_include/LD_LIBRARY_PATH.sh "${HOME}"/zsh_include/LD_LIBRARY_PATH.sh
}
main_caffe_ssd() {
    #! c***f is dead, do not use it anymore.
    sudo apt install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler \
        libopenblas-dev liblapack-dev libatlas-base-dev \
        libgflags-dev libgoogle-glog-dev liblmdb-dev
    sudo apt install --no-install-recommends libboost-all-dev
}

main_6() {
    #wsl set port
    # use 2222,3333 and so on.
    sudo sed -i '/Port /c Port 2222' /etc/ssh/sshd_config
    sudo sed -i '/ListenAddress 0.0.0.0/c ListenAddress 0.0.0.0' /etc/ssh/sshd_config
    sudo sed -i '/PasswordAuthentication no/c PasswordAuthentication yes' /etc/ssh/sshd_config
    sudo service ssh restart
}
main_shellcheck() {
    readonly envi=$(pwd)
    readonly SHELLCHECK="shellcheck-latest.linux.x86_64.tar.xz"
    cd "${HOME}"/
    if [[ ! -d "${HOME}/tmp_install_folder/" ]]; then
        mkdir -p "${HOME}"/tmp_install_folder/
    else
        rm -rf "${HOME}"/tmp_install_folder/
    fi
    proxychains4 wget -P "${HOME}"/tmp_install_folder/ \
        https://github.com/koalaman/shellcheck/releases/download/latest/"${SHELLCHECK}" \
        --user-agent="${USER_AGENT}" \
        --no-check-certificate
    # Extract
    tar xvf "${HOME}"/tmp_install_folder/"${SHELLCHECK}" -C "${HOME}"/tmp_install_folder
    # Make it globally available
    sudo cp "${HOME}"/tmp_install_folder/shellcheck-latest/shellcheck /usr/bin/shellcheck
    # Cleanup
    rm -r "${HOME}"/tmp_install_folder
    cd "${envi}"
}
main_opencv3() {
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
        mkdir -p build_dir
        cd build_dir
        cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local ..
        #make -j "$(cat /proc/cpuinfo | grep "processor" | wc -l)"
        make -j "$(nproc)"
        make install
        # TODO delete last filess
        # then, lib is in  /usr/local/include/opencv2
    }
}
main_go() {
    # set go
    readonly envi=$(pwd)
    cd "${HOME}"
    GO_FILE_NAME="go1.15.linux-amd64.tar.gz"
    pcf wget https://golang.org/dl/"${GO_FILE_NAME}"
    sudo tar -xzf "${GO_FILE_NAME}" -C /usr/local/
    rm "${GO_FILE_NAME}"
    # add GOPATH for /etc/profile and "${HOME}"/.zshrc now
    cd "${envi}"
}
main_vmware() {
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
main_ryus() {
    #download python2 and ryus
    sudo apt install python2 mininet python3-ryu iputils-arping -y
    #`python2` names `python` in ubuntu1804 and elders.
}
main_nodejs() {
    main_version_of_nodejs=15
    curl -sL https://deb.nodesource.com/setup_"${main_version_of_nodejs}".x | sudo -E bash -
    sudo apt install -y nodejs
}
main_13() {
    sudo ln -s "$(pwd)"/init.wsl /etc/init.wsl
}
function main_linguist() {
    sudo apt install pkg-config libicu-dev zlib1g-dev libcurl4-openssl-dev libssl-dev ruby-dev
    gem sources --add https://mirrors.tuna.tsinghua.edu.cn/rubygems/ --remove https://rubygems.org/
    gem sources -l
    gem install github-linguist
    # now $(github-linguist --breakdown) can use
}
function main_sshkeygen() {
    readonly pre_path="${HOME}/.ssh/"
    readonly file_name="${pre_path}"/YOUR_FILE_NAME
    readonly github_path="${pre_path}"/github
    ssh-keygen -t ed25519 -C "nanoseedskc@gmail.com" -f "${file_name}"
    sudo ln -s "${file_name}" "${github_path}"
    sudo ln -s "${file_name}".pub "${github_path}".pub
    xclip -selection clipboard <"${file_name}".pub
    #! DONT FORGET ADD PATH to zshrc
}
function main_gpgkeygen() {
    gpg --list-secret-keys --keyid-format LONG
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
main_index "$@"
exit 0
# do it after the all cript!
# TODO source ~/.zshrc;
# better do it by self: "source ~/.zshrc"
