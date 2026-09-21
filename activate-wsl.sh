#!/usr/bin/env bash
set -euo pipefail

# Builds and activates the home-manager config for WSL Ubuntu.
# Self-locates so it works no matter where you cloned the repo.
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# On a fresh machine, home-manager isn't installed as a standalone command
# yet (it gets added to the profile by the first activation itself, via
# programs.home-manager.enable in home-wsl.nix). Fall back to `nix run`.
if command -v home-manager >/dev/null 2>&1; then
  home-manager switch --flake "$DIR#ashish@wsl"
else
  nix run home-manager/master -- switch --flake "$DIR#ashish@wsl"
fi
