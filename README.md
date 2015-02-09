* .vim in a hurry
This repo contains everything you need to make a .vim directory

1/ Clone it locally anywhere on you filesystem

git clone https://github.com/bokehsensei/vimconf.git
cd vimconf
git submodule init
git submodule update

rm -rf ~/.vim  # if need be

cd ~
ln -s ~/repo/vimconf  .vim # assuming ~/repo is where you cloned vimconf

