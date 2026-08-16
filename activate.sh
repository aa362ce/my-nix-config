#!/usr/bin/env bash
set -euo pipefail

# Rebuilds and activates the nix-darwin system config, which also activates
# the home-manager config since it's wired in as a nix-darwin module.
sudo darwin-rebuild switch --flake ~/.config/nix-darwin#Ashishs-MacBook-Pro
