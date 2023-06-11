{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    (import ../packages/lvimgui.nix)
    (import ../packages/lunar-client.nix)
    gnomeExtensions.vitals
    gnomeExtensions.user-themes
    gnomeExtensions.bluetooth-battery
    gnomeExtensions.spotify-controller
    vlc
    insomnia
    direnv
    wget
    nixpkgs-fmt
    alacritty
    spotify
    vscode
    lazygit
    nodePackages.neovim
    fd
    ripgrep
    python311Packages.pynvim
    git
    wl-clipboard
    ninja
    gcc
    gnumake
    python3
    cmake
  ];
  programs.neovim = { enable = true; };
  dconf.settings = import ./tiago/dconf.nix { lib = lib; };
  gtk = {
    enable = true;

    iconTheme = {
      name = "ePapirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    cursorTheme = {
      name = "Vanilla-DMZ";
      package = pkgs.vanilla-dmz;
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
        gtk-cursor-theme-name=Vanilla-DMZ
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
        gtk-cursor-theme-name=Vanilla-DMZ
      '';
    };
  };
  programs.git = {
    enable = true;
    userName = "coffee-is-power";
    userEmail = "tiagodinis33@proton.me";
  };
  home.file.".p10k.zsh".source = tiago/.p10k.zsh;
  home.file.".p10k.zsh".executable = true;
  home.file.".config/lvim".source = tiago/.config/lvim;
  home.shellAliases = { lg = "lazygit"; };

  programs.gh.enable = true;
  programs.gh.enableGitCredentialHelper = true;
  programs.gh.settings.editor = "lvim";
  programs.zsh = {
    enable = true;
    initExtra = ''
      source $HOME/.p10k.zsh
      export PATH=$PATH:$HOME/.local/bin:~/.npm-global/
      eval "$(direnv hook zsh)"
    '';
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
        {
          name = "romkatv/powerlevel10k";
          tags = [ "as:theme" "depth:1" ];
        } # Installations with additional options. For the list of options, please refer to Zplug README.
      ];
    };
  };
  home.stateVersion = "23.05";
}
