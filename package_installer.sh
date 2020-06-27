#~!/bin/bash

# install system packages
sudo apt-get install net-tools
sudo apt-get install open-ssh-server

# [install development packages]
#----------------------------------------------------------------
sudo apt-get install build-essential
sudo apt-get install git

# nvim
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install neovim

# svn
sudo apt-get install subversion

# rabbisVCS
sudo add-apt-repository ppa:rabbitvcs/ppa
sudo apt-get update
sudo apt-get install rabbitvcs-nautilus rabbitvcs-cli

## pip
sudo apt install python3-pip

# tmux
sudo apt-get install tmux

## node
sudo curl -sL install-node.now.sh/lts | sudo bash
sudo curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn

# zsh & oh-my-zsh
sudo apt-get install curl
sudo apt-get install zsh
chsh -s /usr/bin/zsh
echo $SHELL
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

# cmake
sudo apt-get install libssl-dev
wget https://cmake.org/files/v3.16/cmake-3.16.2.tar.gz
tar -xzvf cmake-3.16.2.tar.gz
cd cmake-3.16.2
./bootstrap --prefix=/usr/local
make
make install

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# ripgrep
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
sudo dpkg -i ripgrep_11.0.2_amd64.deb

# nerd-font
git clone https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
./install.sh Hack

# clang
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
sudo ./llvm/sh 9
sudo apt-get install clang-9 clang-tools-9 clang-9-doc libclang-common-9-dev libclang-9-dev libclang1-9 clang-format-9 python-clang-9 clangd-9 

# Qt (login version)
sudo apt-get install qt5-default
wget -c download.qt.io/official_releases/qt/5.9/5.9.9/qt-opensource-linux-x64-5.9.9.run
sudo chmod +x qt-opensource-linux-x64-5.9.9.run
sudo ./qt-opensource-linux-x64-5.9.9.run

# Boost
wget -c http://sourceforge.net/projects/boost/files/boost/1.69.0/boost_1_69_0.tar.bz2/download
tar xf boost_1_69_0.tar.bz2
cd boost_1_69_0
sudo ./bootstrap.sh
sudo ./b2
sudo ./b2 install

# Opencv
sudo apt-get install libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
sudo apt-get install python3-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libdc1394-22-dev
mkdir ~/OpenCV
cd ~/OpenCV
wget -O opencv-3.4.6.zip https://github.com/opencv/opencv/archive/3.4.6.zip
wget -O opencv_contrib-3.4.6.zip https://github.com/opencv/opencv_contrib/archive/3.4.6.zip
unzip opencv-3.4.6.zip
unzip opencv_contrib-3.4.6.zip
mkdir ~/OpenCV/opencv-3.4.6/build
cd ~/OpenCV/opencv-3.4.6/build

cmake \
-DCMAKE_BUILD_TYPE=Release \
-DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-3.4.6/modules/ \
-DWITH_OPENGL=ON \
-DWITH_CUDA=ON \
-DWITH_CUFFT=ON \
-DWITH_CUBLAS=ON \
-DBUILD_opencv_cudacodec=OFF \
-DWITH_TBB=ON \
-DBUILD_JAVA=OFF \
-DBUILD_PERF_TEST=OFF \
-DBUILD_DOCS=OFF \
-DWITH_QT=ON \
-DBUILD_EXAMPLES=ON \
..

CORE=$(nproc --all)
make -j${CORE}-1
sudo make install

# [ Programming languages ]
#----------------------------------------------------------------
# Python
sudo apt install software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install python3.8

### install ccls
sudo apt install zlib1g-dev libncurses-dev
sudo apt install rapidjson-dev

git clone --depth=1 --recursive https://github.com/MaskRay/ccls
cd ccls

# Download "Pre-Built Binaries" from https://releases.llvm.org/download.html
# and unpack to /path/to/clang+llvm-xxx.
# Do not unpack to a temporary directory, as the clang resource directory is hard-coded
# into ccls at compile time!
# See https://github.com/MaskRay/ccls/wiki/FAQ#verify-the-clang-resource-directory-is-correct
cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DUSE_SYSTEM_RAPIDJSON=OFF -DCMAKE_PREFIX_PATH=/usr/lib/llvm-9
cmake --build Release
sudo cmake --build Release --target install
# cmake --build . --config Release --target install

sudo npm i -g bash-language-server
pip3 install cmake-language-server


# [ Themes ]
#----------------------------------------------------------------
# gnome shells
sudo apt-get install dconf-cli
git clone https://github.com/dracula/gnome-terminal
cd gnome-terminal
./install.sh

# clone git repository
git clone https://github.com/ralpioxxcs/dotfiles.git
cd dotfiles
mv zshrc ~/.zshrc
mv tmux.conf ~/.tmux.conf
cp nvim ~/.config/nvim
