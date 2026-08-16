{ pkgs, ... }: {

  environment.systemPackages = [
    pkgs.git
    pkgs.curl
    pkgs.wget
    pkgs.iterm2
    pkgs.meslo-lgs-nf
  ];

  programs.zsh.enable = true;

  homebrew = {
    enable = true;
    casks = [ "claude" ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = 5;
}
