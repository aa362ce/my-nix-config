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

## 4. Clone this repo and activate

```bash
git clone <your-remote-url> ~/code/my-nix-config
cd ~/code/my-nix-config
chmod +x activate-wsl.sh
./activate-wsl.sh
```

There's no separate "install home-manager" step — on a fresh machine the
`home-manager` command doesn't exist yet, so `activate-wsl.sh` detects that
and bootstraps the first run via `nix run home-manager/master -- switch
--flake .#ashish@wsl`. That first run installs `home-manager` itself into
your profile (via `programs.home-manager.enable` in
[home-wsl.nix](home-wsl.nix)), so every run after that uses the plain
`home-manager` command directly and is much faster.

The first run builds everything from scratch (claude-code, terraform,
google-cloud-sdk, jdk21, ffmpeg, etc. all get compiled/fetched), so expect
it to take several minutes.

## 5. Set zsh as your default shell (optional)

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

## Troubleshooting

**`./activate-wsl.sh: line 7: home-manager: command not found`** — this
happens if you're on an older copy of `activate-wsl.sh` that assumed
`home-manager` was already installed. Pull the latest version of this repo;
the current script falls back to `nix run home-manager/master --` when the
`home-manager` command isn't on `PATH` yet, so it bootstraps itself on a
completely fresh install.
