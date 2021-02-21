#!/bin/bash
# Installer for LukusAurelius's setup

#sudo apt update
#sudo apt install unzip vim tmux mosh curl -y

# Install fish and other utils
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update
sudo apt install unzip vim tmux mosh curl fish bat -y
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Set default shell to fish
sudo chsh -s $(which fish) luke

# Install fish plugins
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
fish -c fisher install PatrickF1/fzf.fish

# Install starship prompt
curl -fsSL https://starship.rs/install.sh > ~/starship_install.sh
sudo bash ~/starship_install.sh -f
rm ~/starship_install.sh
