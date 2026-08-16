{ pkgs, lib, ... }: {

  home.username = "ashish";
  home.homeDirectory = lib.mkForce "/Users/ashish";
  home.stateVersion = "24.05";

  home.packages = [
    pkgs.python3
    pkgs.oh-my-zsh
    pkgs.zsh-powerlevel10k
    #pkgs.vim <-- removed, programs.vim handles this
    pkgs.zsh-autosuggestions
    pkgs.zsh-syntax-highlighting
    pkgs.nodejs
    pkgs.zoxide
    pkgs.claude-code
    pkgs.google-cloud-sdk
    pkgs.terraform
    pkgs.docker
    pkgs.docker-compose
    pkgs.colima
    pkgs.jdk21
    pkgs.poppler
    pkgs.ffmpeg
    pkgs.gh
    pkgs.imessage-exporter
    pkgs.ollama
    pkgs.yt-dlp
  ];

  programs.zsh = {
    enable = true;
    initContent= ''
      export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh
      export ZSH_THEME=""
      plugins=(
        git
        docker
        docker-compose
        python
        pip
        node
        npm
        nvm
        macos
        z
        history
        colored-man-pages
      ) 
      source $ZSH/oh-my-zsh.sh
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
      # zoxide (smarter z)
      eval "$(zoxide init zsh)"
      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      export NPM_CONFIG_PREFIX=~/.npm-global
      export PATH="$HOME/.npm-global/bin:$PATH"
    '';
  };

  programs.vim = {
    enable = true;
    extraConfig = ''
      set number
      set relativenumber
      set autoindent
      set smartindent
      set expandtab
      set tabstop=2
      set shiftwidth=2
      set softtabstop=2
      set cursorline
      filetype plugin indent on
      syntax on
    '';
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "Ashish Bhatt";
      user.email = "ashishdit2006@gmail.com";
    };
  };
}
