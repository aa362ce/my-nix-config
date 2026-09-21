#!/usr/bin/env bash
set -euo pipefail

# Builds and activates the home-manager config for WSL Ubuntu.
# Self-locates so it works no matter where you cloned the repo.
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
home-manager switch --flake "$DIR#ashish@wsl"
