#! /usr/local/bin/env bash

#
# [INSTALL]
#

# install cargo
echo 'Installing cargo...'
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
echo 'cargo done!'

# Install alacritty
echo 'Installing alacritty...'
cargo install --locked alacritty
echo 'If failed, run this first: pacman -S cmake freetype2 fontconfig pkg-config make libxcb libxkbcommon python'
echo "done!"

# Install fish
echo 'Installing fish...'
apt install fish
echo "done!"

# Install font
echo 'Installing font [JetBrains]...'
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
unzip JetBrainsMono.zip -d ~/.local/share/fonts/
fc-cache -fv
echo "done!"

# Install zellij
echo 'Installing zellij...'
cargo install --locked zellij
echo "done!"

# Install ripgrep
echo 'Installing ripgrep...'
cargo install --locked ripgrep
echo "done!"

# Install zoxide
echo 'Installing zoxide...'
cargo install --locked zoxide
echo "done!"

# Install gitui
echo 'Installing gitui...'
cargo install --locked gitui
echo "done!"


#
# [LINK]
#

# TODO: create links for all the dotfiles to ~/.config

