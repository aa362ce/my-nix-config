# WSL Ubuntu setup

First-time setup for using this repo's `home-manager` config on WSL Ubuntu
(under Windows). This mirrors the Mac setup in [flake.nix](flake.nix) /
[home.nix](home.nix), but via standalone `home-manager` instead of
`nix-darwin` + Homebrew, since WSL Ubuntu isn't NixOS.

## 1. Install WSL + Ubuntu (Windows side)

Skip this if you already have a WSL Ubuntu install. From PowerShell (as
Administrator):

```powershell
wsl --install -d Ubuntu
```

Reboot if prompted, then launch "Ubuntu" from the Start menu and finish the
first-run prompts (create a Unix username/password).

## 2. Install Nix (inside the WSL Ubuntu shell)

```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```

Close and reopen the WSL terminal afterward so `nix` is on `PATH`.

## 3. Enable flakes

```bash
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

## 4. Install home-manager

```bash
nix run home-manager/master -- init
```

## 5. Clone this repo and activate

```bash
git clone <your-remote-url> ~/code/my-nix-config
cd ~/code/my-nix-config
chmod +x activate-wsl.sh
./activate-wsl.sh
```

This builds and switches to the `ashish@wsl` home-manager configuration
defined in [home-wsl.nix](home-wsl.nix).

## 6. Set zsh as your default shell (optional)

home-manager installs zsh but doesn't change your login shell. If you want
it as the default:

```bash
chsh -s $(which zsh)
```

Then close and reopen the WSL terminal.

## Making changes later

Edit [home-wsl.nix](home-wsl.nix), then re-run:

```bash
./activate-wsl.sh
```

## Notes / differences from the Mac config

- No `nix-darwin` equivalent is used — WSL Ubuntu is a regular Ubuntu
  system, so OS-level packages still come from `apt` as usual. Only the
  user environment (shell, dotfiles, CLI tools) is managed by Nix here.
- No Homebrew casks — GUI apps (browser, editor, etc.) should be installed
  normally on the Windows side, not through this config.
- Dropped from the Mac package list: `colima` (Docker Desktop replacement,
  not needed on Linux), `imessage-exporter` (macOS-only), and the
  `macos` oh-my-zsh plugin.
- `docker`/`docker-compose` CLIs are not included by default — most WSL
  setups get them via Docker Desktop's WSL integration. Add
  `pkgs.docker` / `pkgs.docker-compose` to [home-wsl.nix](home-wsl.nix) if
  you'd rather have Nix provide them.
