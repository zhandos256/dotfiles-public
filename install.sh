#!/bin/bash

brew bundle --file=Brewfile

mkdir -p ~/.config/skhd
mkdir -p ~/.config/yabai
mkdir -p ~/.config/alacritty
mkdir -p ~/.config/karabiner

cp -r nvim ~/.config
cp -r alacritty ~/.config
cp -r skhdrc ~/.config/skhd
cp -r yabairc ~/.config/yabai

cp .aliases ~/
cp .vimrc ~/
cp .tmux.conf ~/
cp .zshrc ~/
cp new_bot.sh ~/files
cp ac.sh ~/files
