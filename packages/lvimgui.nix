let lvim = (import ./lvim.nix);
in with (import <nixpkgs> { });
buildEnv {
  name = "lvimgui";
  paths = [
    neovide
    (writeShellScriptBin "lvimgui" ''
      export PATH="$PATH:${lazygit}/bin"
      export PATH="$PATH:${neovim}/bin"
      export PATH="$PATH:${fd}/bin"
      export PATH="$PATH:${ripgrep}/bin"
      export PATH="$PATH:${python311Packages.pynvim}/bin"
      export PATH="$PATH:${git}/bin"
      export PATH="$PATH:${wl-clipboard}/bin"
      export PATH="$PATH:${ninja}/bin"
      export PATH="$PATH:${gcc}/bin"
      export PATH="$PATH:${gnumake}/bin"
      export PATH="$PATH:${python3}/bin"
      export PATH="$PATH:${cmake}/bin"
      export LUNARVIM_CONFIG_DIR="$HOME/.config/lvim"
      export LUNARVIM_CACHE_DIR="$HOME/.cache/lvim"
      export LUNARVIM_RUNTIME_DIR="$HOME/.local/share/lunarvim"
      export LUNARVIM_BASE_DIR="${lvim}/lunarvim/lvim"
      export NEOVIDE_APP_ID="lunarvim-gui";
      export NEOVIDE_WM_CLASS="lunarvim-gui";
      export NEOVIDE_WM_CLASS_INSTANCE="lunarvim-gui"
      ${neovide}/bin/neovide -- -u "$LUNARVIM_BASE_DIR/init.lua" "$@"
    '')
    (makeDesktopItem {
      name = "lvimgui-desktop-icon";
      desktopName = "LunarVim (GUI)";
      comment =
        "An IDE layer for Neovim with sane defaults. Completely free and community driven.";
      genericName = "Text Editor";
      categories = [ "Utility" "TextEditor" "Development" "IDE" ];
      exec = "lvimgui %F";
      startupWMClass = "lunarvim-gui";
      mimeTypes = [ "text/plain" ];
      keywords = [ "neovim" "neovide" "lunarvim" "gui" "lvimgui" ];
      icon = builtins.fetchurl {
        url = "https://www.lunarvim.org/img/lunarvim_icon.png";
        sha256 =
          "c9915b6722d37bbfcdd6b8d7fdb089ac874bdd25e4aeaaa71c9483f2cc7ac43f";
      };
    })
  ];
}
