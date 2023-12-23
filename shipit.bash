#!/bin/bash
# Unofficial "just ship it" script for fly.io apps
# Configuration
INSTALL_FLY="https://fly.io/install.sh"
ACCESS_TOKEN="" # Leave blank for login prompt

# --------------------------

# smooshed together by @gavingogaming

if [ ! -d "$HOME/.fly" ]; then
    sudo curl "$INSTALL_FLY" | sh
    export PATH="$HOME/.fly/bin:$PATH"
    if [ "$ACCESS_TOKEN" == "" ]; then
        fly auth login
    fi
fi

if [[ $PATH == *".fly/bin"* ]]; then
    echo "Fly in path, will not export"
else
    export PATH="$HOME/.fly/bin:$PATH"
fi

if [ "$1" == "-e" ]; then
    if [ "$ACCESS_TOKEN" == "" ]; then
        fly deploy
    else
        fly deploy -t "$ACCESS_TOKEN"
    fi
else
    if [ "$ACCESS_TOKEN" == "" ]; then
        fly launch --generate-name --now 
    else
        fly launch -t "$ACCESS_TOKEN"
    fi
fi