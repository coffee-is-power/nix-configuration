{ config, pkgs, ... }:

{
  # ----------------------------- Rofi -----------------------------
  programs.rofi = {
    enable = true;
    cycle = true;
    # Set terminal to alacritty
    terminal = "${pkgs.alacritty}/bin/alacritty";
  };

  # --------------------------- Hyprland ---------------------------
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # Set mod key to super
      "$mod" = "SUPER";

      input = {
        # Set keyboard layout to portuguese
        kb_layout = "pt";
        # Enable touchpad natural scroll
        touchpad.natural_scroll = "yes";
      };
      # Enable workspace swipe
      gestures.workspace_swipe = "yes";

      bind = [
        "$mod, D, exec, ${pkgs.rofi}/bin/rofi -show drun"
        ", Print, exec, ${pkgs.grimblast}/bin/grimblast copy area"
      ] ++ (
        # Workspace keybind
        # $mod + {1..10} to workspace {1..10}
        # $mod + shift + {1..10} to move to workspace {1..10}
        builtins.concatLists (builtins.genList (x:
          let
            ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
          in [
            "$mod, ${ws}, workspace, ${toString (x + 1)}"
            "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
          ]) 10));
    };
  };

  # ------------------------------- Git Config ----------------------------------
  programs.git = {
    enable = true;
    userName = "Tiago Dinis";
    userEmail = "tiagodinis33@proton.me";
  };

  # ----------------------------- VS Code config --------------------------------
  programs.vscode.enable = true;

  # --------------------------------- Lazygit -----------------------------------
  programs.lazygit.enable = true;

  # -------------------------------- Alacritty ----------------------------------
  programs.alacritty.enable = true;

  # ------------------- Setup basic home manager settings -----------------------
  home.username = "tiago";
  home.homeDirectory = "/home/tiago";
  home.stateVersion = "23.11";
  home.packages = with pkgs; [ nixfmt ];
  # --------------------------- Allow unfree packages ---------------------------
  nixpkgs.config.allowUnfree = true;
  # -------------------------------- GTK Theme ----------------------------------
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };
  gtk = {
    enable = true;
    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };

    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "Sans";
      size = 11;
    };
  };
  # -------------------------------- Nushell ----------------------------------
  programs.nushell.enable = true;
  # --------------------------------- Helix -----------------------------------
  programs.helix.enable = true;
  programs.helix.defaultEditor = true;
}
