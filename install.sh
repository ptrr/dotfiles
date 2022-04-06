#!/usr/bin/env bash

function check_prog() {
    if ! hash "$1" > /dev/null 2>&1; then
        echo "Command not found: $1. Aborting..."
        exit 1
    fi
}

check_prog stow
check_prog curl

mkdir -p "$HOME/.config"

stow --target "$HOME" --no-folding nvim
stow --target "$HOME" --no-folding zsh
stow --target "$HOME" --no-folding git
stow --target "$HOME" --no-folding kitty
stow --target "$HOME" --no-folding alacritty
