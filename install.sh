#!/bin/sh
sudo ln -s /home/$USER/colorapt/capt-get /usr/local/sbin/apt-get
sudo ln -s /home/$USER/colorapt/capt-search /usr/local/sbin/apt-search
mkdir ~/.bash_completion.d
cd bash-completion
cp * ~/.bash_completion.d/

cat << EOF >> ~/.bashrc
# tab completion for colorapt
. ~/.bash_completion.d/capt-get
. ~/.bash_completion.d/capt-build
. ~/.bash_completion.d/capt-cache
EOF
