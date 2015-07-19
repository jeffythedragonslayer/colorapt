#!/bin/sh

if [ ! -f "/usr/local/sbin/capt-get" ]; then
	sudo ln -s ~/colorapt/capt-get /usr/local/sbin/capt-get
fi

if [ ! -f "/usr/local/sbin/capt-search" ]; then
	sudo ln -s ~/colorapt/capt-search /usr/local/sbin/capt-search
fi

d=~/.bash_completion.d 
if [ ! -d "$d" ]; then
	mkdir $d
fi

cd ~/.bash_completion.d/
cp /usr/share/bash-completion/completions/apt-* .
sed -i 's/_apt/_capt/g' *
sed -i 's/complete\(.*\) apt-/complete\1 capt-/g' *

mv apt-build capt-build
mv apt-cache capt-cache
mv apt-get   capt-get

cat << EOF >> ~/.bashrc
# tab completion for colorapt
. ~/.bash_completion.d/capt-get
. ~/.bash_completion.d/capt-build
. ~/.bash_completion.d/capt-cache
EOF
