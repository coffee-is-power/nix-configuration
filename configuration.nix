# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/refs/heads/release-22.11.zip";
in
{
  boot.initrd.systemd.enable = true;
  boot.kernelParams = [ "quiet" ];
  boot.plymouth.enable = true;
  boot.plymouth.theme = "breeze";

  hardware.opengl.enable = true;
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
    ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  nixpkgs.config = {
    allowUnfree = true;
  };
  networking.hostName = "nixos-lenovo"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Lisbon";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "pt_PT.UTF-8";
    supportedLocales = [
      "pt_PT.UTF-8/UTF-8"
    ];
  };
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "pt";
    useXkbConfig = true; # use xkbOptions in tty.
  };
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  #  programs.ly.enable = true;
  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  # hardware.pulseaudio.enable = true;
  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    gnome-terminal
    gedit # text editor
    epiphany # web browser
    geary # email reader
    evince # document viewer
    gnome-characters
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]);
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;
  users.users.tiago = {
    isNormalUser = true;
    hashedPassword = "$6$P.YM/w.J2xObgWpw$4GjcGERojaUchT11BmOwAIa3G3lW7OeeXJrEExq5keAH.58/rhicA9ZosOTvslMJWWYtSpSMXloGwMsyZhWHr0";
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      gnomeExtensions.vitals
      gnomeExtensions.user-themes
      gnomeExtensions.bluetooth-battery
      rust-analyzer
    ];
  };
  users.users.maria = {
    isNormalUser = true;
    hashedPassword = "$6$lKraicfYF7Ri9IFD$u6HJGUJ8DDIBsMFvUu5UDUkK5evLRvYpWXX9XYV8Anz2XhsiqeGlhYt4R7scom3rxRncYH.YqdHBjGYAJ1Rx50";
    packages = with pkgs; [
      firefox
    ];
  };
  programs.dconf.enable = true;
  home-manager.users.tiago = { lib, ... }: {
    programs.neovim = {
      enable = true;
    };
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
      "org/gnome/shell" = {
        disable-user-extensions = false;

        # `gnome-extensions list` for a list
        enabled-extensions = [
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "Vitals@CoreCoding.com"
          "bluetooth-battery@michalw.github.com"
        ];

      };

      "org/gnome/shell/extensions/user-theme" = {
        # name = "some theme"
      };
      "org/gnome/desktop/input-sources" = {
        sources = [
          (lib.hm.gvariant.mkTuple [ "xkb" "pt" ])
          (lib.hm.gvariant.mkTuple [ "ibus" "mozc-jp" ])
        ];
      };
      "org/gnome/desktop/peripherals/mouse" = {
        speed = -0.8;
        natural-scroll = false;
      };
      "org/gnome/desktop/peripherals/touchpad" = {
        click-method = "areas";
        speed = 0.0;
        natural-scroll = true;
        tap-to-click = true;
        edge-scrolling-enabled = true;
        two-finger-scrolling-enabled = false;
        send-events = "enabled";
      };
    };

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
    home.file.".p10k.zsh".source = ./.p10k.zsh;
    home.file.".p10k.zsh".executable = true;
    home.shellAliases = {
      lg = "lazygit";
    };

    programs.gh.enable = true;
    programs.gh.enableGitCredentialHelper = true;
    programs.gh.settings.editor = "code --wait";
    programs.zsh = {
      enable = true;
      initExtra = "source $HOME/.p10k.zsh;export PATH=$PATH:$HOME/.local/bin;";
      zplug = {
        enable = true;
        plugins = [
          { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
          { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; } # Installations with additional options. For the list of options, please refer to Zplug README.
        ];
      };
    };
    home.stateVersion = "22.11";
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
  fonts.fonts = with pkgs; [
    meslo-lgs-nf
    carlito
    dejavu_fonts
    ipafont
    kochi-substitute
    source-code-pro
    ttf_bitstream_vera
  ];
  fonts.fontconfig.defaultFonts = {
    monospace = [
      "DejaVu Sans Mono"
      "IPAGothic"
    ];
    sansSerif = [
      "DejaVu Sans"
      "IPAPGothic"
    ];
    serif = [
      "DejaVu Serif"
      "IPAPMincho"
    ];
  };

  services.gvfs.enable = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    ninja
    gcc
    gnumake    
    python3
    cmake
    vim
    wget
    git
    nixpkgs-fmt
    discord
    firefox
    alacritty
    spotify
    vscode
    lazygit
    rustup
    mkpasswd
    neofetch
  ];
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "unstable"; # Did you read the comment?
  services.gnome.gnome-keyring.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  i18n = {
    inputMethod = {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [ mozc ];
    };
  };
}

