with (import <nixpkgs> { });
derivation {
  name = "lvim";
  version = "1.3.0";
  builder = "${bash}/bin/bash";
  args = [
    "-c"
    ''
      set -xe
      export PATH=$PATH:${coreutils}/bin;
      mkdir $out/{bin,lunarvim/lvim} -p;
      cp -rv $src/* $out/lunarvim/lvim

      # Setup lvim binary
      export NVIM_APPNAME="lvim"

      export LUNARVIM_RUNTIME_DIR="\$HOME/.local/share/lunarvim/"
      export LUNARVIM_CONFIG_DIR="\$HOME/.config/$NVIM_APPNAME"
      export LUNARVIM_CACHE_DIR="\$HOME/.cache/$NVIM_APPNAME"
      export LUNARVIM_BASE_DIR="$out/lunarvim/$NVIM_APPNAME"

      export src="$out/lunarvim/lvim/utils/bin/lvim.template"
      export dst="$out/bin/$NVIM_APPNAME"
      echo 'export PATH="$PATH:${lazygit}/bin"' > "$dst"
      echo 'export PATH="$PATH:${neovim}/bin"' >> "$dst"
      echo 'export PATH="$PATH:${fd}/bin"' >> "$dst"
      echo 'export PATH="$PATH:${ripgrep}/bin"' >> "$dst"
      echo 'export PATH="$PATH:${python311Packages.pynvim}/bin"' >> "$dst"
      echo 'export PATH="$PATH:${git}/bin"' >> "$dst"
      echo 'export PATH="$PATH:${wl-clipboard}/bin"' >> "$dst"
      echo 'export PATH="$PATH:${ninja}/bin"' >> "$dst"
      echo 'export PATH="$PATH:${gcc}/bin"' >> "$dst"
      echo 'export PATH="$PATH:${gnumake}/bin"' >> "$dst"
      echo 'export PATH="$PATH:${python3}/bin"' >> "$dst"
      echo 'export PATH="$PATH:${cmake}/bin"' >> "$dst"
      ${gnused}/bin/sed -e s"#NVIM_APPNAME_VAR#\"$NVIM_APPNAME\"#"g \
        -e s"#RUNTIME_DIR_VAR#\"$LUNARVIM_RUNTIME_DIR\"#"g \
        -e s"#CONFIG_DIR_VAR#\"$LUNARVIM_CONFIG_DIR\"#"g \
        -e s"#CACHE_DIR_VAR#\"$LUNARVIM_CACHE_DIR\"#"g \
        -e s"#nvim -u#\"${pkgs.neovim}/bin/nvim\" -u#"g \
        -e s"#BASE_DIR_VAR#\"$LUNARVIM_BASE_DIR\"#"g "$src" >> "$dst"
      chmod +x "$dst"
    ''
  ];
  system = builtins.currentSystem;
  src = fetchFromGitHub {
    owner = "LunarVim";
    repo = "LunarVim";
    rev = "8626cb78d2857d4781b35d6db5289a52046c2eef";
    sha256 = "sha256-xL3+AlLvAs0luxMdc4SXKljd0wLH2njMH8pKd0RSgkY=";
  };
}
