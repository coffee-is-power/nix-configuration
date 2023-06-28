{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    (import ../packages/lunar-client.nix)
    (import ../packages/lvim.nix)
    (import ../packages/lvimgui.nix)
    spotify
    remmina
    vlc
    insomnia
    direnv
    wget
    nixpkgs-fmt
    alacritty
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
    gimp
  ];
  programs.neovim = { enable = true; };
  gtk = {
    enable = true;

    iconTheme = {
      name = "Tokyonight-Dark-Cyan";
      package = import ../packages/tokyonight-theme.nix;
    };

    theme = {
      name = "Tokyonight-Dark-BL";
      package = import ../packages/tokyonight-theme.nix;
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
  home.sessionVariables.GTK_THEME = "Tokyonight-Dark-BL";
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
